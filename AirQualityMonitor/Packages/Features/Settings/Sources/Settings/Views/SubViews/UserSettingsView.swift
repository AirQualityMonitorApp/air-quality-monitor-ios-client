import Authentication
import SessionManager
import SwiftUI

struct UserSettingsView: View {
    
    @ObservedObject var sessionManager: SessionManager
    @ObservedObject var viewModel: SettingsView.SettingsViewModel
    @StateObject var userSettingsViewModel = UserSettingsViewModel()
    
    let size: CGSize
    
    var body: some View {
        Section(header: Text("User Settings")
            .font(.bodyH4)) {
                HStack {
                    Text("User-ID:")
                        .font(.footnoteH6)
                        .foregroundColor(.fontPrimary)
                    Spacer()
                    Text(sessionManager.userID)
                        .font(.footnoteH7)
                        .foregroundColor(.fontPrimary)
                }
                NavigationLink(destination: ChangePasswordView(viewModel: userSettingsViewModel, interactor: UserSettingsInteractor(viewModel: userSettingsViewModel, sessionManager: sessionManager), size: size)) {
                    Text("Change password")
                        .font(.footnoteH6)
                        .foregroundColor(.fontPrimary)
                }
                SettingsButton(
                    text: "Log out",
                    action: {
                        sessionManager.logOut()
                    }
                )
                NavigationLink(destination: DeleteAccountView(viewModel: userSettingsViewModel, interactor: UserSettingsInteractor(viewModel: userSettingsViewModel, sessionManager: sessionManager), size: size)) {
                    Text("Delete Account")
                        .font(.footnoteH6)
                        .foregroundColor(.red)
                }
            }
    }
}

#if DEBUG
struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingsView(sessionManager: SessionManager(), viewModel: SettingsView.SettingsViewModel(), size: CGSize(width: 1000, height: 2000))
    }
}
#endif
