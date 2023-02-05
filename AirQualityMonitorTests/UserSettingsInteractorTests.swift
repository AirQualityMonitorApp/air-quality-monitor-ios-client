import XCTest
import Firebase
@testable import AirQualityMonitor

final class UserSettingsInteractorTests: XCTestCase {
    
    var mockInteractor: UserSettingsInteractor!
    var mockSessionManager: SessionManager!
    var mockViewModel: UserSettingsViewModel!
    
    @MainActor override func setUp() {
        mockSessionManager = SessionManager()
        mockViewModel = UserSettingsViewModel()
        mockInteractor = UserSettingsInteractor(viewModel: mockViewModel, sessionManager: mockSessionManager)
    }
    
    func testChangePassword_newPasswordNotMatching_errorMessageSet() {
        // Given
        mockViewModel.newPassword = "password1"
        mockViewModel.newPasswordRepeat = "password2"
        
        // When
        mockInteractor.changePassword()
        
        // Then
        XCTAssertEqual(mockViewModel.changePasswordErrorMessage, .newPasswordNotMatching)
    }
    
    func testChangePassword_newPasswordMatching() {
        // Given
        mockViewModel.newPassword = "password1"
        mockViewModel.newPasswordRepeat = "password1"
        
        // When
        mockInteractor.changePassword()
        
        // Then
        XCTAssertEqual(mockViewModel.changePasswordErrorMessage, .none)
    }
    
    @MainActor func testDeleteAccount() {
        mockSessionManager.appState = .authorized
        
        
    }
}

