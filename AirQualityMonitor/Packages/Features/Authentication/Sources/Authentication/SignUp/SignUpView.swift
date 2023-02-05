import SessionManager
import SwiftUI

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
    
    //    @ObservedObject var validation: CredentialsValidation
    
    public var body: some View {
        VStack {
            BackToLoginButton(sessionManager: sessionManager, size: size)
            VStack {
                HStack {
                    VStack {
                        EmailFieldView(email: $signUp.email)
                            .frame(width: size.width * 0.9, height: size.height * 0.07)
                            .padding(.bottom, 5)
                        //Text(validation.emailInvalidMessage)
                        
                        PasswordFieldView(password: $signUp.password, placeholder: "Password")
                            .frame(width: size.width * 0.9, height: size.height * 0.07)
                            .padding(.bottom, 5)
                        //PasswordFieldView(password: $validation.repeatPassword)
                        //Text(validation.passwordInvalidMessage)
                        PasswordFieldView(password: $signUp.password, placeholder: "Repeat Password")
                            .frame(width: size.width * 0.9, height: size.height * 0.07)
                            .padding(.bottom, 5)
                    }
                }
                .padding(.vertical, 20)
                ActionButton(
                    signUp: signUp,
                    size: size,
                    action: {
                        signUp.createNewUser(
                            email: signUp.email, password: signUp.password
                        )},
                    text: "Sign Up")
            }
            .frame(width: size.width, height: size.height * 0.6, alignment: .center)
            .padding(.top, 0)
            
        }
        .background(Color.white)
        .frame(width: size.width, height: size.height, alignment: .top)
        .padding(.top, 20)
    }
}
