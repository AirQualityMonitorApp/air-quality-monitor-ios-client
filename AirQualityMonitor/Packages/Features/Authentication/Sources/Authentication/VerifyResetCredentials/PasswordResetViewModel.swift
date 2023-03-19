import Combine
import Foundation
import Models
import Networking

public class VerifyResetCredentialsViewModel: ObservableObject {
    
    public init() {}
    
    @Published var email = ""
    private var cancellables = Set<AnyCancellable>()
    
    @Published var emailLinkIsSent = false
    
    func verifyEmailResetPassword(path: String) {
        
        let apiClient = APIClient(baseURL: BaseUrl().url)
        
        apiClient.dispatch(VerifyReset(path: path, method: .post, body: ["email": self.email]))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in
                    self.emailLinkIsSent = true
                },
                receiveValue: { _ in
                })
            .store(in: &cancellables)
    }
}

public struct VerifyReset: Request {
    
    public var userId: String?
    public var authToken: String?
    public typealias ReturnType = VerifyResetModel
    public var path: String
    public var method: HTTPMethod
    public var body: [String: Any]?
    
    public init(userId: String? = nil, authToken: String? = nil, path: String, method: HTTPMethod, body: [String : Any]? = nil) {
        self.userId = userId
        self.authToken = authToken
        self.path = path
        self.method = method
        self.body = body
    }
}
