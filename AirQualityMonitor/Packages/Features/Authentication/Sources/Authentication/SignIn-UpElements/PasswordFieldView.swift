import SwiftUI

public struct PasswordFieldView: View {
    
    var password: Binding<String>
    let placeholder: String
    
    public init(password: Binding<String>, placeholder: String) {
        self.password = password
        self.placeholder = placeholder
    }
    
    public var body: some View {
        
        SecureField(placeholder, text: password)
            .font(.bodyH4)
            .padding()
            .background()
            .cornerRadius(10.0)
            .shadow(radius: 5.0, x: 5, y: 5)
    }
}
