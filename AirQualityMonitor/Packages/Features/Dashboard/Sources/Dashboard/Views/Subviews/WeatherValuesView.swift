import SwiftUI

struct WeatherValuesView: View {
    
    var flexibleLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var valueViewHeight: CGFloat
    var width: CGFloat
    @ObservedObject var viewModel: DashboardView.DashboardViewModel
    
    var body: some View {
        
        LazyVGrid(columns: flexibleLayout, spacing: 5) {
            CircularCardView(
                displayedData: viewModel.celsiusFahrenheitTemp,
                parentViewHeight: valueViewHeight,
                width: width * 0.3,
                color: viewModel.tempColor,
                valueInformation: self.switchFahrenheitCelsiusValues()
            )
            .onChange(of: viewModel.temp, perform: { _ in
                viewModel.updateTemperatureCardsColor(
                    value: viewModel.temp)
            })
            
            CircularCardView(
                displayedData: viewModel.humidity,
                parentViewHeight: valueViewHeight,
                width: width * 0.3,
                color: viewModel.humidityColor,
                valueInformation:  HumidityValueInformation()
            )
            CircularCardView(
                displayedData: viewModel.humidity,
                parentViewHeight: valueViewHeight,
                width: width * 0.3,
                color: viewModel.humidityColor,
                valueInformation: HumidityValueInformation()
            )
            .onChange(of: viewModel.humidity, perform: { _ in
                viewModel.updateHumidityCardsColor(value: viewModel.humidity)
            })
        }
        .padding(EdgeInsets(top: 10, leading: 6, bottom: 0, trailing: 6))
    }
}

extension WeatherValuesView {
    func switchFahrenheitCelsiusValues() -> ValueInformation {
        if viewModel.settingsViewModel.isFahrenheit {
            return TempFahrenheitValueInformation()
        } else {
            return TempCelsiusValueInformation()
        }
    }
}
