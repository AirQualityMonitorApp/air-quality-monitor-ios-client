import SwiftUI

struct DeleteAccountErrorMessage: View {
    @ObservedObject var viewModel: UserSettingsViewModel
    
    var body: some View {
        switch viewModel.deleteAccountErrorMessage {
        case .none:
            Text("")
                .font(.bodyLightH5)
                .foregroundColor(.red)
        case .error:
            Text("Something went wrong. Try again.")
                .font(.bodyLightH5)
                .foregroundColor(.red)
        case .wrongPassword:
            Text("The password is not correct")
                .font(.bodyLightH5)
                .foregroundColor(.red)
        default:
            Text("")
                .font(.bodyLightH5)
                .foregroundColor(.red)
        }
    }
}

#if DEBUG
struct DeleteAccountErrorMessage_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountErrorMessage(viewModel: UserSettingsViewModel())
    }
}
#endif
