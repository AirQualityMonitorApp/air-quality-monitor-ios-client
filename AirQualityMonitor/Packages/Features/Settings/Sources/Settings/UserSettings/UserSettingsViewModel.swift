import Foundation

public class UserSettingsViewModel: ObservableObject, UserSettingsViewType {
    
    @Published public var email = ""
    @Published public var oldPassword = ""
    @Published public var newPassword = ""
    @Published public var newPasswordRepeat = ""
    @Published public var deleteAccountPassword = ""
    @Published public var changePasswordErrorMessage: UserSettingsErrorMessage = .none
    @Published public var deleteAccountErrorMessage: UserSettingsErrorMessage = .none
    
    @Published public var isAlert = false
    
    public func toggleAlert() {
        self.isAlert = true
    }
    
    public var isNewPasswordValidated: Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: newPassword)
    }
    
    public var newPasswordsMatching: Bool {
        newPassword == newPasswordRepeat && !newPassword.isEmpty
    }
    
    public var isNewPasswordValid: Bool {
        isNewPasswordValidated && newPasswordsMatching
    }
}

public protocol UserSettingsViewType {
    var email: String { get set }
    var oldPassword: String { get set }
    var newPassword: String { get set }
    var newPasswordRepeat: String { get set }
    var deleteAccountPassword: String { get set }
    var changePasswordErrorMessage: UserSettingsErrorMessage { get set }
    var deleteAccountErrorMessage: UserSettingsErrorMessage { get set }
    var isAlert: Bool { get set }
    func toggleAlert() -> Void
}

public enum UserSettingsErrorMessage {
    case none
    case error
    case wrongPassword
    case success
}
