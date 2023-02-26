import Combine
//import KeychainSwift
import Models
import Networking
import Foundation

public class SignUp: ObservableObject {
    
    @Published public var email = ""
    @Published public var password = ""
    @Published public var passwordRepeat = ""
    public var errorMessage = ""
    
    public init() {}
    
    private var cancellables = Set<AnyCancellable>()
    
    func createNewUser(email: String, password: String, passwordRepeat: String) {
        
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
    
    public var isSignUpValid: Bool {
        isEmailValid && isPasswordValidated && passwordsMatching
    }
    
    public var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
    public var isPasswordValidated: Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    public var passwordsMatching: Bool {
        password == passwordRepeat && !password.isEmpty
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
