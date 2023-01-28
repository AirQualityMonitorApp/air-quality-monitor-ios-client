import Combine
import Models
import Networking
import Foundation

public class SignUp: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func createNewUser(email: String, password: String) {
        
        let apiClient = APIClient(baseURL: BaseUrl().url)
        
        let userBody: UserModel = UserModel(email: email, password: password)
        
        apiClient.dispatch(CreateUser(path: "/user", method: .post, body: userBody.asDictionary))
        
            .sink(
                receiveCompletion: { _ in
                },
                receiveValue: { _ in
                })
            .store(in: &cancellables)
    }
}

struct CreateUser: Request {
    var headers: [String : String]?
    var authToken: String?
    typealias ReturnType = UserModel
    var path: String
    var method: HTTPMethod
    var body: [String: Any]?
    var userId: String?
    
    init(headers: [String : String]? = nil, authToken: String? = nil, path: String, method: HTTPMethod, body: [String : Any]? = nil, userId: String? = nil) {
        self.headers = headers
        self.authToken = authToken
        self.path = path
        self.method = method
        self.body = body
        self.userId = userId
    }
}

extension Encodable {
    var asDictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}
