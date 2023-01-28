import Combine
import Foundation
import Firebase
import Models
import Networking
import SwiftUI

public enum AppState {
    case authorized
    case unauthorized
    case signingIn
    case signinUp
    case passwordReset
    case verifyEmail
    case loading
    case error
}

@MainActor public class SessionManager : ObservableObject {
    var didChange = PassthroughSubject<SessionManager, Never>()
    var session: Models.User? {
        didSet { self.didChange.send(self) }
    }
    var handle: AuthStateDidChangeListenerHandle?
    
    @AppStorage("userID") var userID: String = ""
    @AppStorage("authToken") var authToken: String = ""
    @AppStorage("isUserVerified") var isUserVerfied = false
    
    @Published var email = ""
    @Published var password = ""
    @Published var showSignUpScreen = false
    @Published var appState: AppState = .unauthorized
    @Published var jwtValidity: TokenValidity = .expired
    
    var isErrorMessage = false
    
    private var tokenExpDate = 0
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Got user: \(user)")
                self.session = Models.User(
                    uid: user.uid
                )
            } else {
                self.session = nil
            }
        }
    }
    
    func firebaseSignIn(
        email: String,
        password: String,
        handler: @escaping (AuthDataResult?, Error?) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}

extension SessionManager {
    
    func signIn() {
        self.appState = .signingIn
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
        self.appState = .signingIn
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
        self.listen()
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

extension SessionManager {
    public func checkSessionOnStartup() async {
        guard self.isUserVerfied != false else { return }
        guard self.session != nil else { return }
        if self.jwtValidity == .expired {
            return await self.refreshUserAuthorization()
        }
        self.appState = .authorized
    }
    
    public func checkUserIsVerified() {
        guard self.isUserVerfied else {
           return self.appState = .verifyEmail
        }
    }
}

extension SessionManager {
    func showResetPasswordView() {
        self.appState = .passwordReset
    }
}

public enum TokenValidity {
    case valid
    case expired
}
