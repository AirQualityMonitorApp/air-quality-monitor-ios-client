import Combine
import Foundation
import Models

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case delete  = "DELETE"
}

public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var userId: String? { get }
    var body: [String: Any]? { get }
    var authToken: String? { get }
    var headers: [String: String]? { get }
    associatedtype ReturnType: Codable
}

extension Request {
    public var method: HTTPMethod { return .get }
    public var contentType: String { return "application/json" }
    var queryParams: [String: String]? { return nil }
    var body: [String: Any]? { return nil }
    public var headers: [String: String]? { return nil }
}

extension Request {
    
    private func requestBodyFrom(params: [String: Any]) -> Data? {
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) else {
            return nil
        }
        return httpBody
    }
    
    func asURLRequest(baseURL: String) -> URLRequest? {
        
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        if request.httpMethod == "POST" {
            request.httpBody = requestBodyFrom(params: body ?? [:])

        }
        request.addValue((authToken ?? ""), forHTTPHeaderField: "Authorization")
        request.addValue((userId ?? ""), forHTTPHeaderField: "userId")
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        request.addValue(contentType, forHTTPHeaderField: "Accept")
        
        request.allHTTPHeaderFields = headers
        return request
    }
    
}

public enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
}

public struct NetworkDispatcher {
    
    let urlSession: URLSession!
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<[ReturnType], NetworkRequestError> {
        
        return urlSession
            .dataTaskPublisher(for: request)
            .tryMap({ data, response in
                
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    
                    throw httpError(response.statusCode)
                }
                return data
            })
            .decode(type: [ReturnType].self, decoder: JSONDecoder())
            .mapError { error in
                print(error)
                return handleError(error)
            }
            .eraseToAnyPublisher()
    }
}

extension NetworkDispatcher {
    
    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
    
    private func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
}

public struct APIClient {
    
    public var baseURL: String!
    public var networkDispatcher: NetworkDispatcher!
    public init(baseURL: String,
         networkDispatcher: NetworkDispatcher = NetworkDispatcher()) {
        self.baseURL = baseURL
        self.networkDispatcher = networkDispatcher
    }
    
    public func dispatch<R: Request>(_ request: R) -> AnyPublisher<[R.ReturnType], NetworkRequestError> {
        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            return Fail(outputType: [R.ReturnType].self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        typealias RequestPublisher = AnyPublisher<[R.ReturnType], NetworkRequestError>
        let requestPublisher: RequestPublisher = networkDispatcher.dispatch(request: urlRequest)
        return requestPublisher.eraseToAnyPublisher()
    }
}

public struct FetchData: Request {
    public var contentType: String?
    public var body: [String : Any]?
    public typealias ReturnType = AirQuality
    public var path: String
    public var authToken: String?
    public var method: HTTPMethod
    public var userId: String?
    
    public init(body: [String : Any]? = nil, path: String, authToken: String? = nil, method: HTTPMethod, userId: String? = nil) {
        self.body = body
        self.path = path
        self.authToken = authToken
        self.method = method
        self.userId = userId
    }
}
