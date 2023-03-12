import Authentication
import Dashboard
import SessionManager
import Settings
import SwiftUI
import UIKit

struct ViewRouter: View {
    
    @ObservedObject var settingsViewModel: SettingsView.SettingsViewModel
    @ObservedObject var sessionManager: SessionManager
    var dashboardInteractor: DashboardInteractor
    
    
    let size: CGSize
    
    init(settingsViewModel: SettingsView.SettingsViewModel, sessionManager: SessionManager, dashboardInteractor: DashboardInteractor, size: CGSize) {
        self.settingsViewModel = settingsViewModel
        self.sessionManager = sessionManager
        self.dashboardInteractor = dashboardInteractor
        self.size = size
        let appearance = UITabBar.appearance()
        appearance.backgroundColor = UIColor(Color.backgroundPrimary)
        appearance.unselectedItemTintColor = UIColor(.green)
    }

    var body: some View {
        VStack{
            HeaderView(headerHeight: size.height * 0.08)
            TabView {
                DashboardView(interactor: dashboardInteractor,
                    width: size.width,
                    dashboardViewHeight: size.height * 0.8
                )
                .onAppear {
                    Task {
                        await dashboardInteractor.updateAirQualityData()
                    }
                }
                .onReceive(dashboardInteractor.timer, perform: { _ in
                    Task {
                        await dashboardInteractor.updateAirQualityData()
                    }
                })
                .tabItem() {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
                SettingsView(
                    viewModel: settingsViewModel,
                    sessionManager: sessionManager, size: size
                )
                .tabItem() {
                    Image(systemName: "gearshape.2.fill")
                    Text("Settings")
                }
            }.accentColor(.green)
        }
        .background(Color.green.ignoresSafeArea())
    }
}
