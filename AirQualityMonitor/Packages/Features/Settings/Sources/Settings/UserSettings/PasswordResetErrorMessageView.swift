import SwiftUI

struct ChangePasswordErrorMessage: View {
    
    @ObservedObject var viewModel: UserSettingsViewModel
    
    var body: some View {
        switch viewModel.changePasswordErrorMessage {
        case .none:
            Text("")
                .font(.bodyLightH5)
                .foregroundColor(.red)
        case .error:
            Text("Something went wrong. Try again.")
                .font(.bodyLightH5)
                .foregroundColor(.red)
        case .wrongPassword:
            Text("The current password is not correct")
                .font(.bodyLightH5)
                .foregroundColor(.red)
        case .success:
            Text("The password has been successfully modified!")
                .font(.bodyLightH5)
                .foregroundColor(.green)
        }
    }
}

struct PasswordResetErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordErrorMessage(viewModel: UserSettingsViewModel())
    }
}
