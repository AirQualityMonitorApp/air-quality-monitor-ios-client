import SessionManager
import SwiftUI

public struct BackToLoginButton: View {
    
    @ObservedObject var sessionManager: SessionManager
    
    let size: CGSize
    
    func backToSignInView() {
        sessionManager.appState = .unauthorized
        sessionManager.isErrorMessage = false
    }
    
    public var body: some View {
        VStack {
            Button(action: {
                backToSignInView()},
            label: {
                Text("Back to login")
                    .foregroundColor(.green)
                    .font(.headlineH3)
            })
            .frame(width: size.width * 0.35, height: size.height * 0.06, alignment: .center)
            .background()
            .cornerRadius(10.0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: size.height * 0.06, leading: size.width * 0.05, bottom: 0, trailing: 0))    }
}

#if DEBUG
struct BackToLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        BackToLoginButton(sessionManager: SessionManager(), size: CGSize(width: 200, height: 100))
    }
}
#endif
