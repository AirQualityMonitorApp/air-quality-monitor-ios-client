import SwiftUI
import UIComponents

public struct EmailFieldView: View {
    
    var email: Binding<String>
    
    public var body: some View {
        
        TextField("Email", text: email)
            .font(.bodyH4)
            .padding()
            .background()
            .cornerRadius(10.0)
            .shadow(radius: 5.0, x: 5, y: 5)
            .textInputAutocapitalization(.never)
    }
        
}
