import Authentication
import SessionManager
import SwiftUI

struct ChangePasswordView: View {
    
    @ObservedObject var viewModel: UserSettingsViewModel
    var interactor: UserSettingsInteractor
    
    let size: CGSize
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack {
                        PasswordFieldView(password: $viewModel.oldPassword, placeholder: "Old password")
                            .modifier(PasswordFieldModifier(size: size))
                        PasswordFieldView(password: $viewModel.newPassword, placeholder: "New password")
                            .modifier(PasswordFieldModifier(size: size))
                        PasswordFieldView(password: $viewModel.newPasswordRepeat, placeholder: "Repeat new password")
                            .modifier(PasswordFieldModifier(size: size))
                    }
                }
                .padding(.vertical, 20)
                ActionButton(
                    size: size,
                    action: {
                        interactor.changePassword()
                    },
                    text: "Change Password")
                .disabled(!viewModel.isNewPasswordValid)
                .opacity(viewModel.isNewPasswordValid ? 1.0 : 0.5)
                HStack {
                    ChangePasswordErrorMessage(viewModel: viewModel)
                }
                .padding(.top, 10)
                ChangePasswordValidationList(isPasswordValid: viewModel.isNewPasswordValidated, passwordsMatching: viewModel.newPasswordsMatching)
            }
            .frame(width: size.width, height: size.height * 0.6, alignment: .center)
            .padding(.top, 0)
        }
        .background(Color.white)
        .frame(width: size.width, height: size.height * 0.7, alignment: .top)
        .padding(.top, 20)
    }
}

struct PasswordFieldModifier: ViewModifier {
    let size: CGSize
    func body(content: Content) -> some View {
      content
           .frame(width: size.width * 0.9, height: size.height * 0.07)
           .padding(.bottom, 5)
  }
}

#if DEBUG
struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(viewModel: UserSettingsViewModel(), interactor: UserSettingsInteractor(viewModel: UserSettingsViewModel(), sessionManager: SessionManager()), size: CGSize(width: 1000, height: 2000))
    }
}
#endif
