import SessionManager
import SwiftUI
import Utilities_Extensions

public struct SignUpView: View {
    
    @ObservedObject var signUp: SignUp
    @ObservedObject var sessionManager: SessionManager
    
    let size: CGSize
    
    func backToSignInView() {
        sessionManager.appState = .unauthorized
        sessionManager.isErrorMessage = false
    }
    
    public init(signUp: SignUp, sessionManager: SessionManager, size: CGSize) {
        self.signUp = signUp
        self.sessionManager = sessionManager
        self.size = size
    }
    
    public var body: some View {
        VStack {
            BackToLoginButton(sessionManager: sessionManager, size: size)
            VStack {
                HStack {
                    VStack {
                        EmailFieldView(email: $signUp.email)
                            .modifier(InputFieldModifier(size: size))
                        PasswordFieldView(password: $signUp.password, placeholder: "Password")
                            .modifier(InputFieldModifier(size: size))
                        PasswordFieldView(password: $signUp.passwordRepeat, placeholder: "Repeat Password")
                            .modifier(InputFieldModifier(size: size))
                    }
                }
                .padding(.vertical, 20)
                ActionButton(
                    signUp: signUp,
                    size: size,
                    action: {
                        signUp.createNewUser(
                            email: signUp.email, password: signUp.password, passwordRepeat: signUp.passwordRepeat
                        )},
                    text: "Sign Up")
                .disabled(!signUp.isSignUpValid)
                .opacity(signUp.isSignUpValid ? 1.0 : 0.5)
                
                ValidationList(isEmailValid: signUp.isEmailValid, isPasswordValid: signUp.isPasswordValidated, passwordsMatching: signUp.passwordsMatching)
            }
            .frame(width: size.width, height: size.height * 0.6, alignment: .center)
            .padding(.top, 0)
            
        }
        .background(Color.white)
        .frame(width: size.width, height: size.height, alignment: .top)
        .padding(.top, 20)
    }
}

fileprivate struct InputFieldModifier: ViewModifier {
    let size: CGSize
    func body(content: Content) -> some View {
      content
           .frame(width: size.width * 0.9, height: size.height * 0.07)
           .padding(.bottom, 5)
  }
}
