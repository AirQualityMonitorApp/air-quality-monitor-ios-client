import Combine
import Foundation
import Models
import Networking
import SessionManager
import Settings

@MainActor
public class DashboardInteractor {
    
    public let viewModel: DashboardView.DashboardViewModel
    public let sessionManager: SessionManager
    public let settingsViewModel: SettingsView.SettingsViewModel
    
    public let dataLoader: DataLoader
    
    public init(viewModel: DashboardView.DashboardViewModel, settingsViewModel: SettingsView.SettingsViewModel, sessionManager: SessionManager, dataLoader: DataLoader) {
        self.viewModel = viewModel
        self.settingsViewModel = settingsViewModel
        self.sessionManager = sessionManager
        self.dataLoader = dataLoader
    }
    
    public var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    private var cancellables = Set<AnyCancellable>()
    private let defaultValue: Double = 0
    
    public func assignAirQualityData(data: [FetchData.ReturnType]) {
        DispatchQueue.main.async { [self] in
            data.forEach { data in
                viewModel.co2 = data.co2 ?? self.defaultValue
                viewModel.temp = data.temperature ?? self.defaultValue
                viewModel.voc = data.tvoc ?? self.defaultValue
                viewModel.humidity = data.humidity ?? self.defaultValue
                viewModel.pm = data.pm ?? self.defaultValue
                viewModel.aqiScore = data.AQScore ?? Int(self.defaultValue)
            }
        }
    }
    
    public func updateAirQualityData() async {
        await sessionManager.checkSessionBeforeUpdating()
        await self.loadAirQualityData(userId: sessionManager.userID)
    }
    
    private func loadAirQualityData(userId: String) async {
        await dataLoader.fetchAirQualityData(userId: userId, sessionManager: sessionManager)
        self.assignAirQualityData(data: dataLoader.airQualityData)
    }
}

@MainActor
public class DataLoader: ObservableObject {
    
    @Published public var airQualityData = [FetchData.ReturnType]()
    public var cachedHistoryData = [AirQuality]()
    
    public init() {}
    
    private var cancellables = Set<AnyCancellable>()
    
    public func fetchAirQualityData(userId: String, sessionManager: SessionManager) async {
        let apiClient = APIClient(baseURL: BaseUrl().url)
        apiClient.dispatch(FetchData(path: "/api/my", authToken: sessionManager.authToken, method: .get, userId: userId))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { data in
                self.airQualityData = data
            })
            .store(in: &cancellables)
    }
}
