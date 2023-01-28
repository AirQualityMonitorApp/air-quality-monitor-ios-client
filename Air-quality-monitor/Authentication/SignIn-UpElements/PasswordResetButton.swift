import SwiftUI

struct PasswordResetButton: View {
    var size: CGSize
    var action: () -> ()
    var body: some View {
        ZStack {
            Button(
                action: {action()},
                label: { Text("Password reset")
                    .font(.footnoteH7)
                    .foregroundColor(.green)
                }
            )
        }
        .frame(maxWidth: .infinity, alignment: .topTrailing)
        .padding(.trailing, size.width * 0.06)
    }
}
// test
struct PasswordResetButton_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetButton(size: CGSize(width: 200, height: 100), action: {})
    }
}
