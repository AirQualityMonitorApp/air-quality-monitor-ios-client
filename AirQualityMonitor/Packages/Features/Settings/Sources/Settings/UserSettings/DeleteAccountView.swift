import Authentication
import SessionManager
import SwiftUI

struct DeleteAccountView: View {
    
    @ObservedObject var viewModel: UserSettingsViewModel
    var interactor: UserSettingsInteractor
    
    let size: CGSize
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack {
                        PasswordFieldView(password: $viewModel.deleteAccountPassword, placeholder: "Password")
                            .modifier(PasswordFieldModifier(size: size))
                    }
                }
                .padding(.vertical, 20)
                ActionButton(
                    size: size,
                    action: {
                        viewModel.toggleAlert()
                    },
                    text: "Delete account")
                .alert(isPresented: $viewModel.isAlert, content: {
                    Alert(title: Text("Attention!").foregroundColor(.red), message: Text("Do you really want to delete your account?"),
                          primaryButton: Alert.Button.default(Text("Yes").foregroundColor(.red), action: {
                        interactor.handleDeleteAccount()
                        }),
                        secondaryButton: Alert.Button.cancel(Text("No"), action: {
                        viewModel.isAlert = false
                        })
                    )
                })
                HStack {
                    DeleteAccountErrorMessage(viewModel: viewModel)
                }
                .padding(.top, 10)
            }
            .frame(width: size.width, height: size.height * 0.6, alignment: .center)
            .padding(.top, 0)
        }
        .background(Color.white)
        .frame(width: size.width, height: size.height, alignment: .top)
        .padding(.top, 20)
    }
}



struct DeleteAccountView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountView(viewModel: UserSettingsViewModel(), interactor: UserSettingsInteractor(viewModel: UserSettingsViewModel(), sessionManager: SessionManager()), size: CGSize(width: 1000, height: 2000))
    }
}
