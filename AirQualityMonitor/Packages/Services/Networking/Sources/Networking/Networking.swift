import Combine
import Foundation
import Models

public enum HTTPMethod: String {
    case get = "GET"
}

public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var body: [String: Any]? { get }
    var headers: [String : String]? { get }
    var customHeaders: CustomHeaders? { get }
    associatedtype ReturnType: Codable
}

extension Request {
    public var method: HTTPMethod { return .get }
    public var contentType: String { return "application/json" }
    var queryParams: [String: String]? { return nil }
    var body: [String: Any]? { return nil }
    public var headers: [String : String]? { return nil }
    var customHeaders: CustomHeaders? { return nil }
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
        request.addValue(customHeaders?.headerValue1 ?? "", forHTTPHeaderField: customHeaders?.customHeader1 ?? "")
        request.addValue(customHeaders?.headerValue2 ?? "", forHTTPHeaderField: customHeaders?.customHeader2 ?? "")
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
    
    public var baseURL: String
    public var networkDispatcher: NetworkDispatcher
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
    public var method: HTTPMethod
    public var customHeaders: CustomHeaders?
    
    
    public init(body: [String : Any]? = nil, path: String, method: HTTPMethod, customHeaders: CustomHeaders? = nil) {
        self.body = body
        self.path = path
        self.method = method
        self.customHeaders = customHeaders
    }
}

public struct CustomHeaders: Hashable {
    public init(customHeader1: String? = nil, customHeader2: String? = nil, headerValue1: String? = nil, headerValue2: String? = nil) {
        self.customHeader1 = customHeader1
        self.customHeader2 = customHeader2
        self.headerValue1 = headerValue1
        self.headerValue2 = headerValue2
    }
    
    let customHeader1: String?
    let customHeader2: String?
    let headerValue1: String?
    let headerValue2: String?
}
