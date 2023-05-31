import Dashboard
import Settings
import SwiftUI
import UIKit

struct ViewRouter: View {
    let dashboardPresenter: DashboardPresenting
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var dashboardViewModel: DashboardViewModel
    var settingsViewModel: SettingsViewModel
    
    init(dashboardPresenter: DashboardPresenter, dashboardViewModel: DashboardViewModel, settingsViewModel: SettingsViewModel) {
        self.dashboardPresenter = dashboardPresenter
        self.dashboardViewModel = dashboardViewModel
        self.settingsViewModel = settingsViewModel
        let appearance = UITabBar.appearance()
        appearance.backgroundColor = UIColor(Color.backgroundPrimary)
        appearance.unselectedItemTintColor = UIColor(.green)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                TabView {
                    DashboardView(
                        valuesViewData: ValuesViewData(
                            viewDataItems: dashboardViewModel.dataItems,
                            width: geometry.size.width,
                            updateAirQualityData: dashboardPresenter.updateAirQualityData,
                            aqiValuesModel: AQIValuesModel(
                                value: dashboardViewModel.aqiScore.value,
                                color: dashboardViewModel.aqiScore.color,
                                isSelected: dashboardViewModel.aqiScore.isSelected,
                                updateAQIValueColor: dashboardPresenter.updateAQIValueColor)),
                        dashboardViewHeight: geometry.size.height * 0.85
                    )
                    .tabItem() {
                        Image(systemName: "house.fill")
                        Text("Dashboard")
                    }
                    SettingsView(
                        viewModel: settingsViewModel,
                        size: geometry.size,
                        updateValues: dashboardPresenter.updateAirQualityData
                    )
                    .tabItem() {
                        Image(systemName: "gearshape.2.fill")
                        Text("Settings")
                    }
                }
                .accentColor(.green)
            }
            .onAppear {
                dashboardPresenter.updateAirQualityData()
            }
            .onChange(of: scenePhase) { newScenePhase in
                if newScenePhase == .active {
                    dashboardPresenter.updateAirQualityData()
                }
            }
            .onReceive(dashboardPresenter.getInterval(), perform: { _ in
                dashboardPresenter.updateAirQualityData()
            })
            .background(Color.green.ignoresSafeArea())
        }
        .background(
            Color.white
        )
        .edgesIgnoringSafeArea(.all)
    }
}
