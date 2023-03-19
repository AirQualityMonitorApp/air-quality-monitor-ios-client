import Combine
import Foundation
import Firebase
import Models
import Networking
import SwiftUI

public enum AppState {
    case authorized
    case unauthorized
    case signinUp
    case passwordReset
    case verifyEmail
    case loading
    case error
}

@MainActor public class SessionManager : ObservableObject {
    public var didChange = PassthroughSubject<SessionManager, Never>()
    public var session: Models.User? {
        didSet { self.didChange.send(self) }
    }
    public var handle: AuthStateDidChangeListenerHandle?
    
    @AppStorage("userID") public var userID: String = ""
    @AppStorage("authToken") public var authToken: String = ""
    @AppStorage("isUserVerified") public var isUserVerfied = false
    
    @Published public var email = ""
    @Published public var password = ""
    @Published public var showSignUpScreen = false
    @Published public var appState: AppState = .unauthorized
    @Published public var jwtValidity: TokenValidity = .expired
    
    public init() {}
    
    public var isErrorMessage = false
    
    public var tokenExpDate = 0
    
    public func listen() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.session = Models.User(
                    uid: user.uid
                )
            } else {
                self.session = nil
            }
        }
    }
    
    public func firebaseSignIn(
        email: String,
        password: String,
        handler: @escaping (AuthDataResult?, Error?) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    public func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}

public extension SessionManager {
    
    func signIn() {
        self.appState = .loading
        self.firebaseSignIn(email: self.email, password: self.password, handler: { (result, error) in
            result.map { val in
                self.isUserVerfied = val.user.isEmailVerified
                self.getAuthToken(value: val)
                self.userID = val.user.uid
                self.isErrorMessage = false
            }
            
            if error != nil {
                self.appState = .unauthorized
                self.isErrorMessage = true
            } else if !self.isUserVerfied {
                self.appState = .verifyEmail
            } else {
                self.email = ""
                self.password = ""
                self.isErrorMessage = false
                self.appState = .authorized
            }
        })
    }
    
    func getAuthToken(value: AuthDataResult) {
        value.user.getIDToken() { token, error in
            guard (token != nil) else {
                return
            }
            self.jwtValidity = .valid
            self.authToken = token ?? ""
        }
    }
    
    func logOut() {
        self.appState = .loading
        do {
            try Auth.auth().signOut()
            self.unbind()
            self.session = nil
            self.appState = .unauthorized
            self.authToken = ""
            self.userID = ""
            self.isUserVerfied = false
            
        } catch(let error) {
            self.appState = .error
            debugPrint(error.localizedDescription)
        }
        self.appState = .unauthorized
    }
    
    func refreshUserAuthorization() async {
        guard let userInSession = Auth.auth().currentUser else {
            self.appState = .unauthorized
            return self.logOut()
        }
        self.appState = .authorized
        self.refreshJwtToken(user: userInSession)
    }
    
    func refreshJwtToken(user: Firebase.User) {
        user.getIDTokenForcingRefresh(true) {
            token, error in
            guard (token != nil) else {
                return
            }
            let decodedJwt = JwtDecoder.decode(jwtToken: token ?? "")
            self.tokenExpDate = decodedJwt["exp"] as? Int ?? 0
            
            self.authToken = token ?? ""
            self.jwtValidity = .valid
        }
    }
    
    func checkJwtExpirationDate() async {
        
        guard self.userID != "" else {
            return self.logOut()
        }
        guard self.jwtValidity == .valid else {
            return await self.refreshUserAuthorization()
        }
        
        let timeInterval = TimeInterval(self.tokenExpDate)
        let tokenExpAsDate = Date(timeIntervalSince1970: timeInterval)
        if Date() >= tokenExpAsDate {
            self.jwtValidity = .expired
        } else {
            self.jwtValidity = .valid
        }
    }
}

public extension SessionManager {
    func checkSessionBeforeUpdating() async {
        guard self.session != nil else { return }
        if self.jwtValidity == .expired {
            return await self.refreshUserAuthorization()
        }
        await self.checkJwtExpirationDate()
    }
}

public extension SessionManager {
    func checkSessionOnStartup() async {
        guard self.isUserVerfied != false else { return }
        guard self.session != nil else { return }
        if self.jwtValidity == .expired {
            return await self.refreshUserAuthorization()
        }
        self.appState = .authorized
    }
    
    func checkUserIsVerified() {
        guard self.isUserVerfied else {
           return self.appState = .verifyEmail
        }
    }
}

public extension SessionManager {
    public func showResetPasswordView() {
        self.appState = .passwordReset
    }
}

public enum TokenValidity {
    case valid
    case expired
}
