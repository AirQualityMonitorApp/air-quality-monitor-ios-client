import Foundation

public struct BaseUrl {
    public static let productionUrl: String = "https://s4y8v1m45i.execute-api.eu-central-1.amazonaws.com/dev"
    public static let stagingUrl: String = "http://localhost:3000"
    public static let isProduction: Bool = false
    
    public var url: String {
        Self.isProduction ? Self.productionUrl : Self.stagingUrl
    }
    
    public init() {}
}
