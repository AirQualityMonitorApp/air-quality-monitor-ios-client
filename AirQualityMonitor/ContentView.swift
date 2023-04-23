import Dashboard
import Networking
import Settings
import SwiftUI
import UIComponents

struct ContentView: View {
    
    @ObservedObject var settingsViewModel: SettingsViewModel
    @ObservedObject var dashboardViewModel: DashboardViewModel
    
    @State var isErrorPresented = NetworkManager.shared.networkState == .notConnected ? true : false
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ViewRouter(
                    settingsViewModel: settingsViewModel,
                    dashboardViewModel: dashboardViewModel,
                    dashboardInteractor: DashboardInteractor(dashboardViewModel: dashboardViewModel, settingsViewModel: settingsViewModel),
                    size: geometry.size
                )
            }
        }
        .background(
            Color.white
        )
        .edgesIgnoringSafeArea(.all)
    }
}
//
//#if DEBUG
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(dashboardViewModel: DashboardView.DashboardViewModel(settingsViewModel: SettingsView.SettingsViewModel()))
//    }
//}
//#endif
