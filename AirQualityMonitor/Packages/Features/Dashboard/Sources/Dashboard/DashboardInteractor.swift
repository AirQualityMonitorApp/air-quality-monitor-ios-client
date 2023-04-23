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
    
    private func makeCustomHeaders() -> CustomHeaders {
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
                    DataItem(value: data.co2 ?? defaultValue, color: updateCardColor(value: data.co2 ?? defaultValue, valueType: .co2), info: Co2ValueInformation(), isSelected: settingsViewModel.co2IsSelected),
                    DataItem(value: data.pm ?? defaultValue, color: updateCardColor(value: data.temperature ?? defaultValue, valueType: .pm25), info: PMValueInformation(), isSelected: settingsViewModel.pm25IsSelected),
                    DataItem(value: data.tvoc ?? defaultValue, color: updateCardColor(value: data.tvoc ?? defaultValue, valueType: .voc), info: VocValueInformation(), isSelected: settingsViewModel.vocIsSelected),
                    DataItem(value: data.temperature ?? defaultValue, color: updateCardColor(value: data.temperature ?? defaultValue, valueType: .temperature), info: TempCelsiusValueInformation(), isSelected: settingsViewModel.temperatureIsSelected),
                    DataItem(value: data.humidity ?? defaultValue, color: updateCardColor(value: data.humidity ?? defaultValue, valueType: .humidity), info: HumidityValueInformation(), isSelected: settingsViewModel.humidityIsSelected)
                    
                ]
                dashboardViewModel.aqiScore = AirQualityScoreItem(value: data.AQScore ?? 0, color: updateAQIValueColor(value: data.AQScore ?? 0), isSelected: settingsViewModel.aqiScoreIsSelected)
            }
        }
    }

    public func updateAirQualityData() async {
        await self.loadAirQualityData()
    }

    private func loadAirQualityData() async {
        await self.fetchAirQualityData()
    }
    
    public func fetchAirQualityData() async {
        let apiClient = APIClient(baseURL: settingsViewModel.baseUrl)
        let fetchData = FetchData(path: settingsViewModel.urlPath, method: .get, customHeaders: self.makeCustomHeaders())
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
    
    private func setGasPmCardColor(value: Double, level: PmGasLevels) -> Color {
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
            return setGasPmCardColor(value: value, level: PmLevel())
        case .voc:
            return setGasPmCardColor(value: value, level: VocLevel())
        case .temperature:
            return setTempHumidityCardColor(value: value, level: TemperatureLevel())
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
        case pm25
        case temperature
        case humidity
    }
}
