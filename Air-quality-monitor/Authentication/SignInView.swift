import Firebase
import SwiftUI

struct SignInView: View {
    
    @ObservedObject var sessionManager: SessionManager
    var size: CGSize
    
    var body: some View {
        
        VStack {
            LogoView(size: size)
            VStack {
                HStack {
                    VStack {
                        EmailFieldView(email: $sessionManager.email)
                            .frame(width: size.width * 0.9, height: size.height * 0.07)
                            .padding(.bottom, 5)
                        PasswordFieldView(password: $sessionManager.password, placeholder: "Password")
                            .frame(width: size.width * 0.9, height: size.height * 0.07)
                    }
                }
                PasswordResetButton(size: size, action: { sessionManager.showResetPasswordView()})
                ActionButton(
                    size: size,
                    action: {
                        sessionManager.signIn()
                    },
                    text: "Sign In")
                
                HStack {
                    Text("Invalid email or password")
                        .font(.bodyLightH5)
                        .foregroundColor(.red)
                }.isHidden(!sessionManager.isErrorMessage)
            }
            .frame(width: size.width, height: size.height * 0.34, alignment: .center)
            GoToSignUpView(sessionManager: sessionManager, size: size)
        }
        .frame(width: size.width, height: size.height, alignment: .top)
        .padding(.top, 20)
    }
}
