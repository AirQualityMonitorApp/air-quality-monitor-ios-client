import SwiftUI

struct GasPmValuesView: View {
    
    var flexibleLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var valueViewHeight: CGFloat
    var width: CGFloat
    var viewModel: DashboardView.DashboardViewModel
    
    var body: some View {
        
        LazyVGrid(columns: flexibleLayout, spacing: 5) {
            CircularCardView(
                displayedData: viewModel.co2,
                parentViewHeight: valueViewHeight,
                width: width * 0.3,
                color: viewModel.co2Color,
                valueInformation: Co2ValueInformation()
            )
            .onChange(of: viewModel.co2, perform: { _ in
                viewModel.updateCo2CardColor(value: viewModel.co2)
            })
            CircularCardView(
                displayedData: viewModel.voc,
                parentViewHeight: valueViewHeight,
                width: width * 0.3,
                color: viewModel.vocColor,
                valueInformation:  VocValueInformation()
            )
            .onChange(of: viewModel.voc, perform: { _ in
                viewModel.updateVocCardColor(value: viewModel.voc)
            })
            CircularCardView(
                displayedData: viewModel.pm,
                parentViewHeight: valueViewHeight,
                width: width * 0.3,
                color: viewModel.pmColor,
                valueInformation:  PMValueInformation()
            )
            .onChange(of: viewModel.pm, perform: { _ in
                viewModel.updatePmCardColor(value: viewModel.pm)
            })
        }
        .padding(EdgeInsets(top: 10, leading: 6, bottom: 0, trailing: 6))
        Spacer()
        Divider()
    }
}
