import Dashboard
import Settings
import SwiftUI
import UIKit

struct ViewRouter: View {
    
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var settingsViewModel: SettingsViewModel
    @ObservedObject var dashboardViewModel: DashboardViewModel
    let dashboardInteractor: DashboardInteractor
    let size: CGSize
    
    init(settingsViewModel: SettingsViewModel, dashboardViewModel: DashboardViewModel, dashboardInteractor: DashboardInteractor, size: CGSize) {
        self.settingsViewModel = settingsViewModel
        self.dashboardViewModel = dashboardViewModel
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
                .tabItem() {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
                SettingsView(
                    viewModel: settingsViewModel,
                    size: size
                )
                .tabItem() {
                    Image(systemName: "gearshape.2.fill")
                    Text("Settings")
                }
            }
            .accentColor(.green)
        }
        .onAppear {
            Task {
                await dashboardInteractor.updateAirQualityData()
            }
        }
        .onChange(of: scenePhase) { newScenePhase in
            if newScenePhase == .active {
                Task {
                    await dashboardInteractor.updateAirQualityData()
                }
            }
        }
        .onReceive(dashboardInteractor.timer, perform: { _ in
            Task {
                await dashboardInteractor.updateAirQualityData()
            }
        })
        .background(Color.green.ignoresSafeArea())
    }
}
