import Authentication
import Combine
import Firebase
import Foundation
import Models
import Networking
import SessionManager
import SwiftUI

public class UserSettingsInteractor {
    
    let viewModel: UserSettingsViewModel
    @ObservedObject var sessionManager: SessionManager
    
    let user = Auth.auth().currentUser
    
    init(viewModel: UserSettingsViewModel, sessionManager: SessionManager) {
        self.viewModel = viewModel
        self.sessionManager = sessionManager
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func changePassword() {
        guard viewModel.newPassword == viewModel.newPasswordRepeat else {
            return viewModel.changePasswordErrorMessage = .newPasswordNotMatching
        }
        reauthenticateUser(password: viewModel.oldPassword, newPassword: viewModel.newPassword, action: updatePasswordOnFirebase)
    }
    
    func reauthenticateUser(password: String, newPassword: String? = nil, action: @escaping ()->Void) {
        
        
        let credentials = EmailAuthProvider.credential(withEmail: user?.email ?? "", password: password)
        
        user?.reauthenticate(with: credentials, completion: { result, error in
            if error != nil {
                self.viewModel.changePasswordErrorMessage = .wrongPassword
                return
            }
            action()
        })
    }
    
    func updatePasswordOnFirebase() {
        
        user?.updatePassword(to: viewModel.newPassword, completion: { error in
            if let _ = error {
                self.viewModel.changePasswordErrorMessage = .error
            } else {
                self.viewModel.changePasswordErrorMessage = .success
            }
        })
        viewModel.oldPassword = ""
        viewModel.newPassword = ""
        viewModel.newPasswordRepeat = ""
    }
    
    func handleDeleteAccount() {
        reauthenticateUser(password: viewModel.deleteAccountPassword, action: deleteAccountOnFirebase)
    }
    
    func deleteAccountOnFirebase() {
        self.deleteDatabaseDocument(userId: self.sessionManager.userID)
        user?.delete { error in
            if let _ = error {
                self.viewModel.deleteAccountErrorMessage = .error
            } else {
                self.sessionManager.appState = .unauthorized
            }
        }
    }
    
    private func deleteDatabaseDocument(userId: String) {
        
        let apiClient = APIClient(baseURL: BaseUrl().url)
        apiClient.dispatch(DeleteAccount(path: "/deleteUser", authToken: sessionManager.authToken, method: .delete, userId: sessionManager.userID))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                value in
                
                print(value)
            }, receiveValue: { val in
                print(val)
            })
            .store(in: &cancellables)
    }
}

public struct DeleteAccount: Request {
    
    public var contentType: String?
    public var body: [String : Any]?
    public typealias ReturnType = AirQuality
    public var path: String
    public var authToken: String?
    public var method: HTTPMethod
    public var userId: String?
    
    public init(body: [String : Any]? = nil, path: String, authToken: String?, method: HTTPMethod = .delete, userId: String?) {
        self.body = body
        self.path = path
        self.authToken = authToken
        self.method = method
        self.userId = userId
    }
}
