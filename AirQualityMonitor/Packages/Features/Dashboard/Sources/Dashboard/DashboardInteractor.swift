import Combine
import Foundation
import Models
import Networking
import Settings

@MainActor
public class DashboardInteractor {
    
    public let viewModel: DashboardView.DashboardViewModel
    public let settingsViewModel: SettingsView.SettingsViewModel
    
    public init(viewModel: DashboardView.DashboardViewModel, settingsViewModel: SettingsView.SettingsViewModel) {
        self.viewModel = viewModel
        self.settingsViewModel = settingsViewModel
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
        await self.loadAirQualityData()
    }
    
    private func loadAirQualityData() async {
        await self.fetchAirQualityData()
    }
    
    public func fetchAirQualityData() async {
        let apiClient = APIClient(baseURL: BaseUrl().url)
        apiClient.dispatch(FetchData(path: "/api/my", method: .get))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { data in
                self.assignAirQualityData(data: data)
            })
            .store(in: &cancellables)
    }
}

//@MainActor
//public class DataLoader: ObservableObject {
//
//    @Published public var airQualityData = [FetchData.ReturnType]()
//    public var cachedHistoryData = [AirQuality]()
//
//    private let dashboardInteractor: DashboardInteractor
//
//    public init(dashboardInteractor: DashboardInteractor) {
//        self.dashboardInteractor = dashboardInteractor
//    }
//
//    private var cancellables = Set<AnyCancellable>()
//
//    public func fetchAirQualityData(sessionManager: SessionManager) async {
//        let apiClient = APIClient(baseURL: BaseUrl().url)
//        apiClient.dispatch(FetchData(path: "/api/my", authToken: sessionManager.authToken, method: .get, userId: sessionManager.userID))
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { _ in
//            }, receiveValue: { data in
//                self.dashboardInteractor.assignAirQualityData(data: data)
//            })
//            .store(in: &cancellables)
//    }
//}
