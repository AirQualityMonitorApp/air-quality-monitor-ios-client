import Combine
import Foundation
import Models
import Networking

@MainActor
public class DashboardInteractor {
    
    public let viewModel: DashboardView.DashboardViewModel
    public let sessionManager: SessionManager
    public let settingsViewModel: SettingsView.SettingsViewModel
    
    init(viewModel: DashboardView.DashboardViewModel, settingsViewModel: SettingsView.SettingsViewModel, sessionManager: SessionManager) {
        self.viewModel = viewModel
        self.settingsViewModel = settingsViewModel
        self.sessionManager = sessionManager
    }
    
    public var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    private var cancellables = Set<AnyCancellable>()
    private let defaultValue: Double = 0
    
    private func assignAirQualityData(data: [FetchData.ReturnType]) {
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
        guard self.sessionManager.session != nil else { return }
        await self.loadAirQualityData(userId: sessionManager.userID)
        if self.sessionManager.jwtValidity == .expired {
            return await self.sessionManager.refreshUserAuthorization()
        }
        await self.sessionManager.checkJwtExpirationDate()
        
        sessionManager.appState = .authorized
    }
    
    private func loadAirQualityData(userId: String) async {
        let apiClient = APIClient(baseURL: BaseUrl().url)
        apiClient.dispatch(FetchData(path: "/api/my", authToken: sessionManager.authToken, method: .get, userId: sessionManager.userID))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { data in
                self.assignAirQualityData(data: data)
            })
            .store(in: &cancellables)
    }
    
}
