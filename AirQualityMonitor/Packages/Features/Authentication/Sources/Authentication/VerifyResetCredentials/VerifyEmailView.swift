import SessionManager
import SwiftUI
import UIComponents

public struct VerifyEmailView: View {
    
    @ObservedObject var viewModel: VerifyResetCredentialsViewModel
    @ObservedObject var sessionManager: SessionManager
    var size: CGSize
    
    public init(viewModel: VerifyResetCredentialsViewModel, sessionManager: SessionManager, size: CGSize) {
        self.viewModel = viewModel
        self.sessionManager = sessionManager
        self.size = size
    }
    
    public var body: some View {
        VStack {
            BackToLoginButton(sessionManager: sessionManager, size: size)
            VStack {
                HStack {
                    VStack {
                        Text("To log in, you need to verify your account first. If you did not receive a verification link, you can request another one here.")
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
                        viewModel.verifyEmailResetPassword(path: "/verifyEmail")
                        sessionManager.appState = .unauthorized
                    },
                    text: "Send again")
            }
            .frame(width: size.width, height: size.height * 0.6, alignment: .center)
        }
        .background(Color.white)
        .frame(width: size.width, height: size.height, alignment: .top)
        .padding(.top, 20)
    }
}

#if DEBUG
struct VerifyEmailView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyEmailView(viewModel: VerifyResetCredentialsViewModel(), sessionManager: SessionManager(), size: CGSize(width: 1000, height: 2000))
    }
}
#endif
