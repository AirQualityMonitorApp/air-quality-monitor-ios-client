import Combine
//import KeychainSwift
import Models
import Networking
import Foundation

public class SignUp: ObservableObject {
    
    @Published public var email = ""
    @Published public var password = ""
    
    public init() {}
    
    private var cancellables = Set<AnyCancellable>()
    
    func createNewUser(email: String, password: String) {
        //let keychain = KeychainSwift()
        
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

public struct CreateUser: Request {
    public var headers: [String : String]?
    public var authToken: String?
    public typealias ReturnType = UserModel
    public var path: String
    public var method: HTTPMethod
    public var body: [String: Any]?
    public var userId: String?
    
    public init(headers: [String : String]? = nil, authToken: String? = nil, path: String, method: HTTPMethod, body: [String : Any]? = nil, userId: String? = nil) {
        self.headers = headers
        self.authToken = authToken
        self.path = path
        self.method = method
        self.body = body
        self.userId = userId
    }
}

public extension Encodable {
    var asDictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}
