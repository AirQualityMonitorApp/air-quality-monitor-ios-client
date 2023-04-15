import Authentication
import Dashboard
import Firebase
import Networking
import SessionManager
import Settings
import SwiftUI
import UIComponents

struct ContentView: View {
    
    @ObservedObject var settingsViewModel: SettingsView.SettingsViewModel
    @ObservedObject var sessionManager: SessionManager
    @ObservedObject var signUp: SignUp
    @ObservedObject var verifyResetCredentialsViewModel: VerifyResetCredentialsViewModel
    @StateObject var dashboardViewModel: DashboardView.DashboardViewModel
    
    @State var isErrorPresented = NetworkManager.shared.networkState == .notConnected ? true : false
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            VStack {
                self.viewSwitch(size: geometry.size)
            }.onAppear{
                    getUser()
            }
            .alert(isPresented: $isErrorPresented) {
                Alert(title: Text("Connection Error"), message: Text("It seems you are not connected to the internet"), dismissButton: .default(Text("OK")))
            }
        }
        .background(
            Color.white
        )
        .edgesIgnoringSafeArea(.all)
    }
}

extension ContentView {
    func getUser() {
        sessionManager.listen()
    }
    
    @ViewBuilder
    func viewSwitch(size: CGSize) -> some View {
        switch sessionManager.appState {
        case .authorized:
            ViewRouter(
                settingsViewModel: settingsViewModel,
                sessionManager: sessionManager,
                dashboardInteractor: DashboardInteractor(viewModel: dashboardViewModel, settingsViewModel: settingsViewModel, sessionManager: sessionManager),
                size: size
            )
        case .unauthorized:
            SignInView(sessionManager: sessionManager, size: size)
                .onAppear {
                    Task {
                        await sessionManager.checkSessionOnStartup()
                    }
                }
        case .signinUp:
            SignUpView(signUp: signUp, sessionManager: sessionManager, size: size)
        case .verifyEmail:
            VerifyEmailView(viewModel: verifyResetCredentialsViewModel, sessionManager: sessionManager, size: size)
        case .passwordReset:
            PasswordResetView(viewModel: verifyResetCredentialsViewModel, sessionManager: sessionManager, size: size)
        case .loading:
            LoadingView(width: size.width, height: size.height)
        case .error: EmptyView()
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(settingsViewModel: SettingsView.SettingsViewModel(), sessionManager: SessionManager(), signUp: SignUp(), verifyResetCredentialsViewModel: VerifyResetCredentialsViewModel(), dashboardViewModel: DashboardView.DashboardViewModel(settingsViewModel: SettingsView.SettingsViewModel()))
    }
}
#endif
