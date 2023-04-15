import SwiftUI

public struct ActionButton: View {
    @ObservedObject var signUp: SignUp
    var size: CGSize
    var action: () -> ()
    var text: String
    
    public init(signUp: SignUp? = nil, size: CGSize, action: @escaping () -> Void, text: String) {
        self.signUp = signUp ?? SignUp()
        self.size = size
        self.action = action
        self.text = text
    }
    
    
    public var body: some View {
        HStack {
            Button(
                action: { action() },
                label: { Text(text)
                        .foregroundColor(.white)
                    .font(.headlineH3) }
            )
            .frame(width: size.width * 0.25, height: size.height * 0.06)
            .background(Color.green)
            .cornerRadius(10.0)
            .shadow(radius: 5.0, x: 5, y: 5)
        }
    }
}

#if DEBUG
public struct SignUpButton_Previews: PreviewProvider {
    public static var previews: some View {
        ActionButton(signUp: SignUp(), size: CGSize(width: 200, height: 100), action: {}, text: "Sign Up")
    }
}
#endif
