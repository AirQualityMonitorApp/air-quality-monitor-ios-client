import SwiftUI

struct PasswordFieldView: View {
    
    var password: Binding<String>
    let placeholder: String
    
    var body: some View {
        
        SecureField(placeholder, text: password)
            .font(.bodyH4)
            .padding()
            .background()
            .cornerRadius(10.0)
            .shadow(radius: 5.0, x: 5, y: 5)
    }
}
