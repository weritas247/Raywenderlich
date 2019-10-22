import Moya

public enum Marvel {
  
  static private let publicKey = "19ab0f64e2dc1cff1eb6f094ca4e2d66"
  static private let privateKey = "5ef22fa1788baa79b0fdfb99e11cb0b9ef5c57bd"
  
  case comics
}

extension Marvel: TargetType {
  // 1
  public var baseURL: URL {
    return URL(string: "https://gateway.marvel.com/v1/public")!
  }
  
  // 2
  public var path: String {
    switch self {
    case .comics: return "/comics"
    }
  }
  
  // 3
  public var method: Moya.Method {
    switch self {
    case .comics: return .get
    }
  }
  
  // 4
  public var sampleData: Data {
    return Data()
  }
  
  // 5
  public var task: Task {
    let ts = "\(Date().timeIntervalSince1970)"
    // 1
    let hash = (ts + Marvel.privateKey + Marvel.publicKey).md5
    
    // 2
    let authParams = ["apikey": Marvel.publicKey, "ts": ts, "hash": hash]
    
    switch self {
    case .comics:
      // 3
      return .requestParameters(parameters: ["format" : "comic",
                                             "formatType" : "comic",
                                             "orderBy" : "-onsaleDate",
                                             "dateDescriptor" : "lastWeek",
                                             "limit" : 20] + authParams,
       encoding: URLEncoding.default)
    }
  }
  
  // 6
  public var headers: [String: String]? {
    return ["Content-Type": "application/json"]
  }
  
  // 7
  public var validationType: ValidationType {
    return .successCodes
  }
}
