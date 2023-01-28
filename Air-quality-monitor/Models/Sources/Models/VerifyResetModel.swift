import Foundation

public struct VerifyResetModel: Codable, Equatable {
    
    public var email: String
    
    public init(email: String) {
        self.email = email
    }
}
