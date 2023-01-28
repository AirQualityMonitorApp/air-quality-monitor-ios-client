import Combine
import Foundation
import Models
import Networking

public class VerifyResetCredentialsViewModel: ObservableObject {
    
    @Published var email = ""
    private var cancellables = Set<AnyCancellable>()
    
    @Published var emailLinkIsSent = false
    
    func verifyEmailResetPassword(path: String) {
        
        let apiClient = APIClient(baseURL: BaseUrl().url)
        
        apiClient.dispatch(VerifyReset(path: path, method: .post, body: ["email": self.email]))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { val in
                    print(val)
                    self.emailLinkIsSent = true
                },
                receiveValue: { val in
                    print(val)
                    
                })
            .store(in: &cancellables)
    }
}

struct VerifyReset: Request {
    
    var userId: String?
    var authToken: String?
    typealias ReturnType = VerifyResetModel
    var path: String
    var method: HTTPMethod
    var body: [String: Any]?
    
    init(userId: String? = nil, authToken: String? = nil, path: String, method: HTTPMethod, body: [String : Any]? = nil) {
        self.userId = userId
        self.authToken = authToken
        self.path = path
        self.method = method
        self.body = body
    }
    
}
