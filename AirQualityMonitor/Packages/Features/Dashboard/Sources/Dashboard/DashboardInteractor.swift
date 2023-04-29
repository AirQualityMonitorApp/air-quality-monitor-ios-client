import Combine
import SwiftUI
import Foundation
import Models
import Networking
import Settings

@MainActor
public class DashboardInteractor {
    
    public let dashboardViewModel: DashboardViewModel
    public let settingsViewModel: SettingsViewModel
    
    public init(dashboardViewModel: DashboardViewModel, settingsViewModel: SettingsViewModel) {
        self.dashboardViewModel = dashboardViewModel
        self.settingsViewModel = settingsViewModel
    }
    
    private func setCustomHeaders() -> CustomHeaders {
        return CustomHeaders(customHeader1: settingsViewModel.headerField1, customHeader2: settingsViewModel.headerField2, headerValue1: settingsViewModel.headerFieldValue1, headerValue2: settingsViewModel.headerFieldValue2)
    }
    
    public var timer: Publishers.Autoconnect<Timer.TimerPublisher> {
        Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let defaultValue: Double = 0
    
    public func assignAirQualityData(data: [FetchData.ReturnType]) {
        DispatchQueue.main.async { [self] in
            data.forEach { data in
                dashboardViewModel.dataItems = [
                    makeDataItem(with: data.co2, valueType: .co2, isSelected: settingsViewModel.co2IsSelected, info: Co2ValueInformation()),
                    makeDataItem(with: data.pm25, valueType: .pm25, isSelected: settingsViewModel.pm25IsSelected, info: PM25ValueInformation()),
                    makeDataItem(with: data.pm10, valueType: .pm10, isSelected: settingsViewModel.pm10IsSelected, info: PM10ValueInformation()),
                    makeDataItem(with: data.vocIndex, valueType: .voc, isSelected: settingsViewModel.vocIndexIsSelected, info: VocValueInformation()),
                    makeDataItem(with: data.tvoc, valueType: .tvoc, isSelected: settingsViewModel.tvocIsSelected, info: TvocValueInformation()),
                    makeDataItem(with: settingsViewModel.isFahrenheit ? data.tempCelsius?.toFahrenheit() : data.tempCelsius, valueType: settingsViewModel.isFahrenheit ? .tempFahrenheit : .tempCelsius, isSelected: settingsViewModel.temperatureIsSelected, info: settingsViewModel.isFahrenheit ? TempFahrenheitValueInformation() : TempCelsiusValueInformation()),
                    makeDataItem(with: data.humidity, valueType: .humidity, isSelected: settingsViewModel.humidityIsSelected, info: HumidityValueInformation())
                ]
                dashboardViewModel.aqiScore = AirQualityScoreItem(value: data.aqScore ?? 0, color: updateAQIValueColor(value: data.aqScore ?? 0), isSelected: settingsViewModel.aqiScoreIsSelected)
            }
        }
    }
    
    func makeDataItem(with value: Double?, valueType: ValueType, isSelected: Bool, info: ValueInformation) -> DataItem {
        return DataItem(value: value ?? defaultValue, color: updateCardColor(value: value ?? defaultValue, valueType: valueType), info: info, isSelected: isSelected)
    }

    public func updateAirQualityData() async {
        await self.loadAirQualityData()
    }

    private func loadAirQualityData() async {
        await self.fetchAirQualityData()
    }
    
    public func fetchAirQualityData() async {
        let apiClient = APIClient(baseURL: settingsViewModel.baseUrl)
        let fetchData = FetchData(path: settingsViewModel.urlPath, method: .get, customHeaders: self.setCustomHeaders())
        apiClient.dispatch(fetchData)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { data in
                self.assignAirQualityData(data: data)
            })
            .store(in: &cancellables)
    }
}

extension DashboardInteractor {
    private func setTempHumidityCardColor(value: Double, level: TempHumidityLevels) -> Color {
        switch value {
        case level.good:
             return .green
        case level.fairLow:
            return .yellow
        case level.fairHigh:
            return .yellow
        case level.moderateLow:
            return .orange
        case level.moderateHigh:
            return .orange
        case level.poorLow:
            return .blue
        case level.poorHigh:
            return .red
        case level.unhealthyLow:
            return .blue
        case level.unhealthyHigh:
            return.red
        default:
            return .white
        }
    }
    
    private func setGasPmCardColor(value: Double, level: PMGasLevels) -> Color {
        switch value {
        case level.good:
            return .green
        case level.fair:
            return .yellow
        case level.moderate:
            return .orange
        case level.poor:
            return .red
        case level.unhealthy:
            return .purple
        default:
            return .white
        }
    }
    
    public func updateCardColor(value: Double, valueType: ValueType) -> Color {
        switch valueType {
        case .co2:
            return setGasPmCardColor(value: value, level: Co2Level())
        case .pm25:
            return setGasPmCardColor(value: value, level: PM25Level())
        case .pm10:
            return setGasPmCardColor(value: value, level: PM10Level())
        case .voc:
            return setGasPmCardColor(value: value, level: VocLevel())
        case .tvoc:
            return setGasPmCardColor(value: value, level: TvocLevel())
        case .tempCelsius:
            return setTempHumidityCardColor(value: value, level: TemperatureCelsiusLevel())
        case .tempFahrenheit:
            return setTempHumidityCardColor(value: value, level: TemperatureFahrenheitLevel())
        case .humidity:
            return setTempHumidityCardColor(value: value, level: HumidityLevel())
        }
        
    }
    
    public func updateAQIValueColor(value: Int) -> Color {
        let aqiLevels = AQILevels()
        switch value {
        case aqiLevels.good:
            return .green
        case aqiLevels.fair:
            return .yellow
        case aqiLevels.moderate:
            return .orange
        case aqiLevels.poor:
            return .red
        case aqiLevels.unhealthy:
            return .purple
        default:
            return .gray
        }
    }
    
    public enum ValueType {
        case co2
        case voc
        case tvoc
        case pm25
        case pm10
        case tempCelsius
        case tempFahrenheit
        case humidity
    }
}

extension Double {
    func toFahrenheit() -> Double {
        let fahrenheit = (self * 1.8) + 32
        return Double(String(format: "%.1f", fahrenheit)) ?? 0.0
    }
}
