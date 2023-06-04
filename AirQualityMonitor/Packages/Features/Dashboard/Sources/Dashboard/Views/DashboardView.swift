import SwiftUI
import Utilities_Extensions

public struct DashboardView: View {
    
    let valuesViewData: ValuesViewData
    let dashboardViewHeight: CGFloat
    
    public init(valuesViewData: ValuesViewData, dashboardViewHeight: CGFloat) {
        self.valuesViewData = valuesViewData
        self.dashboardViewHeight = dashboardViewHeight
    }
    
    public var body: some View {
            VStack(alignment: .center) {
                ScrollView(.vertical, showsIndicators: false) {
                    AQIView(aqiData: valuesViewData.aqiValuesModel,
                            aqiViewHeight:
                                calculateViewHeight(with: dashboardViewHeight, isAQIViewSelected: valuesViewData.aqiValuesModel?.isSelected ?? false))
                    ValuesView(viewData: valuesViewData, valueViewHeight: dashboardViewHeight * 0.235)
                }
            }
            .frame(width: valuesViewData.width, height: dashboardViewHeight, alignment: .top)
            .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
            .background(Color.backgroundPrimary)
    }
    
    private func calculateViewHeight(with dashboardViewHeight: CGFloat, isAQIViewSelected: Bool) -> CGFloat {
        isAQIViewSelected ? dashboardViewHeight * 0.35 : 0
    }
}
