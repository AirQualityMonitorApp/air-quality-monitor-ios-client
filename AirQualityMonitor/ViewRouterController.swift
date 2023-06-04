import SwiftUI
import Dashboard
import Settings

final class ViewRouterController {
    
    static func provideViewRouter() -> UIViewController {
        let dashboardViewModel = DashboardViewModel()
        let settingsViewModel = SettingsViewModel()
        let dashboardPresenter = DashboardPresenter(dashboardViewModel: dashboardViewModel, settingsViewModel: settingsViewModel)
        let view = ViewRouter(dashboardPresenter: dashboardPresenter, dashboardViewModel: dashboardViewModel, settingsViewModel: settingsViewModel)
        let viewController = UIHostingController(rootView: view)
                
        dashboardPresenter.hostingUI = viewController
        
        return viewController
    }
}
