import SwiftUI

struct ChangePasswordValidationList: View {
    
    let isPasswordValid: Bool
    let passwordsMatching: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Password has 8 characters, 1 uppercase letter, lowercase letter, number, and symbol")
                    .font(.footnoteH7)
                    .padding(.trailing, 16)
                Spacer()
                Image(systemName: isPasswordValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(isPasswordValid ? .green : .red)
            }
            .padding(.vertical, 2)
            .lineLimit(4)
            HStack {
                Text("Matching passwords")
                    .font(.footnoteH7)
                Spacer()
                Image(systemName: passwordsMatching ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(passwordsMatching ? .green : .red)
            }
            .padding(.vertical, 2)
        }
        .padding(.vertical, 40)
        .padding(.horizontal, 20)
    }
}

#if DEBUG
struct ChangePasswordValidationList_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordValidationList(isPasswordValid: false, passwordsMatching: true)
    }
}
#endif
