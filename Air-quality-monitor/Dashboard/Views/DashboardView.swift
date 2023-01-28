import SwiftUI

public struct DashboardView: View {
    
    @ObservedObject var viewModel: DashboardView.DashboardViewModel
    var interactor: DashboardInteractor
    
    var width: CGFloat
    var dashboardViewHeight: CGFloat
    
    public var body: some View {
        VStack(alignment: .center) {
            AQIView(viewModel: viewModel, aqiViewHeight: dashboardViewHeight * 0.35, width: width)
            WeatherValuesView(valueViewHeight: dashboardViewHeight * 0.235, width: width, viewModel: viewModel)
                .isHidden(interactor.settingsViewModel.weatherValuesAreHidden)
            GasPmValuesView(valueViewHeight: dashboardViewHeight * 0.235, width: width, viewModel: viewModel)
                .isHidden(interactor.settingsViewModel.gasPmValuesAreHidden)
        }
        .frame(width: width, height: dashboardViewHeight, alignment: .top)
        .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 0))
        .background(Color.backgroundPrimary)
    }
}


