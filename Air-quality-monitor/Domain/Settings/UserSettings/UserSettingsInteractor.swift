import Firebase
import Foundation
import SwiftUI

public class UserSettingsInteractor {
    
    let viewModel: UserSettingsViewModel
    @ObservedObject var sessionManager: SessionManager
    
    let user = Auth.auth().currentUser
    
    init(viewModel: UserSettingsViewModel, sessionManager: SessionManager) {
        self.viewModel = viewModel
        self.sessionManager = sessionManager
    }
    
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
        user?.delete { error in
            if let _ = error {
                self.viewModel.deleteAccountErrorMessage = .error
            } else {
                self.sessionManager.appState = .unauthorized
            }
        }
    }
}
