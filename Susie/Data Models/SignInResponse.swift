enum DecodingError: Error {
    case decodingFailed
}

struct SignInResponse: Response {
    static func == (lhs: SignInResponse, rhs: SignInResponse) -> Bool {
        return lhs.accessToken == rhs.accessToken
    }
    
    let accessToken: String
    let refreshToken: String
    
    let expiresIn: Int32
    let refreshExpiresIn: Int32
    
    let userRoles: Array<UserRole>
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case refreshExpiresIn = "refresh_expires_in"
        case userRoles
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let accessToken = try container.decodeIfPresent(String.self, forKey: .accessToken)
        let refreshToken = try container.decodeIfPresent(String.self, forKey: .refreshToken)
        let expiresIn = try container.decodeIfPresent(Int32.self, forKey: .expiresIn)
        let refreshExpiresIn = try container.decodeIfPresent(Int32.self, forKey: .refreshExpiresIn)
        let userRoles = try container.decodeIfPresent(Array<UserRole>.self, forKey: .userRoles)

        guard let accessToken = accessToken,
              let refreshToken = refreshToken,
              let expiresIn = expiresIn,
              let refreshExpiresIn = refreshExpiresIn,
              let userRoles = userRoles else {
            throw DecodingError.decodingFailed
        }

        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
        self.refreshExpiresIn = refreshExpiresIn
        self.userRoles = userRoles
    }
}
