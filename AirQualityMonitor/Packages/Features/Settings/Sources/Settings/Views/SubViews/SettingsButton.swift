import SwiftUI

struct SettingsButton: View {
    
    var text: String
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .foregroundColor(.fontPrimary)
                .font(.footnoteH6)
        })
    }
}

#if DEBUG
struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(text: "test", action: {})
    }
}
#endif
