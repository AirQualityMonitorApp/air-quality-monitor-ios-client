import SwiftUI

struct ValidationList: View {
    
    let isEmailValid: Bool
    let isPasswordValid: Bool
    let passwordsMatching: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Valid email format")
                    .font(.footnoteH7)
                Spacer()
                Image(systemName: isEmailValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(isEmailValid ? .green : .red)
            }
            .padding(.vertical, 2)
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
struct ValidationList_Previews: PreviewProvider {
    static var previews: some View {
        ValidationList(isEmailValid: true, isPasswordValid: false, passwordsMatching: true)
    }
}
#endif
