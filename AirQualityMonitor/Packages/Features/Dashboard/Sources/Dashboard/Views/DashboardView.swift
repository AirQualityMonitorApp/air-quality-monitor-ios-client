import SwiftUI
import Utilities_Extensions

public struct DashboardView: View {
    
    var interactor: DashboardInteractor
    
    var width: CGFloat
    var dashboardViewHeight: CGFloat
    
    public init(interactor: DashboardInteractor, width: CGFloat, dashboardViewHeight: CGFloat) {
        self.interactor = interactor
        self.width = width
        self.dashboardViewHeight = dashboardViewHeight
    }
    
    public var body: some View {
        VStack(alignment: .center) {
            AQIView(viewModel: interactor.dashboardViewModel, interactor: interactor, aqiViewHeight: dashboardViewHeight * 0.35, width: width)
            GasPmValuesView(valueViewHeight: dashboardViewHeight * 0.235, width: width, viewModel: interactor.dashboardViewModel)
        }
        .frame(width: width, height: dashboardViewHeight, alignment: .top)
        .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 0))
        .background(Color.backgroundPrimary)
        .onAppear(perform: {
            Task { await self.interactor.updateAirQualityData() }
        })
    }
}


