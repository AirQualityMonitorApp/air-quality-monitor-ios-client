import SwiftUI

struct PasswordResetView: View {
    
    @ObservedObject var viewModel: VerifyResetCredentialsViewModel
    @ObservedObject var sessionManager: SessionManager
    var size: CGSize
    
    var body: some View {
        VStack {
            BackToLoginButton(sessionManager: sessionManager, size: size)
            VStack {
                HStack {
                    VStack {
                        Text("Send a link to reset your password to your email address.")
                            .font(.headlineH3)
                            .foregroundColor(.green)
                            .padding(EdgeInsets(top: 0, leading: size.width * 0.05, bottom: 20, trailing: size.width * 0.05))
                        EmailFieldView(email: $viewModel.email)
                            .frame(width: size.width * 0.9, height: size.height * 0.07)
                            .padding(.bottom, 20)
                    }
                }
                ActionButton(
                    size: size,
                    action: {
                        viewModel.verifyEmailResetPassword(path: "/resetPassword")
                    },
                    text: "Reset")
                Text("If a user account is connected to this email address you will receive a link to reset your password.")
                    .font(.bodyH4)
                    .foregroundColor(.green)
                    .padding(.top, 20)
                    .isHidden(!viewModel.emailLinkIsSent)
            }
            .frame(width: size.width, height: size.height * 0.6, alignment: .center)
        }
        .background(Color.white)
        .frame(width: size.width, height: size.height, alignment: .top)
        .padding(.top, 20)
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView(viewModel: VerifyResetCredentialsViewModel(), sessionManager: SessionManager(), size: CGSize(width: 1000, height: 2000))
    }
}
