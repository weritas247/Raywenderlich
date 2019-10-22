

import Foundation
import Moya

enum Imgur {
  // 1
  static private let cliendId = "edc66a6de8554a2"
  
  // 2
  case upload(UIImage)
  case delete(String)
}


extension Imgur: TargetType {
  // 1
  public var baseURL: URL {
    return URL(string: "https://api.imur.com/3")!
  }
  
  // 2
  public var path: String {
    switch self {
    case .upload: return "/image"
    case .delete(let deletehash): return "/image/\(deletehash)"
    }
  }
  
  // 3
  public var method: Moya.Method {
    switch self {
    case .upload: return .post
    case .delete: return .delete
    }
  }
  
  // 4
  public var sampleData: Data {
    return Data()
  }
  
  // 5
  public var task: Task {
    switch self {
    case .upload(let image):
      let imageData = image.jpegData(compressionQuality: 1.0)!
      return .uploadMultipart([MultipartFormData(provider: .data(imageData),
                                                 name: "image",
                                                 fileName: "card.jpg",
                                                 mimeType: "image/jpg")])
    case .delete:
      return .requestPlain
    }
  }
  
  // 6
  public var headers: [String : String]? {
    return [
      "Authorization": "Client-Id \(Imgur.cliendId)",
      "Content-Type": "application/json"
    ]
  }
  
  // 7
  public var validationType: ValidationType {
    return .successCodes
  }
  
}
