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
    case newPasswordNotMatching
    case success
}
