
import Firebase


enum ValueKey: String {
  case bigLabelColor
  case appPrimaryColor
  case navBarBackground
  case navTintColor
  case detailTitleColor
  case detailInfoColor
  case subscribeBannerText
  case subscribeBannerButton
  case subscribeVCText
  case subscribeVCButton
  case shouldWeIncludePluto
  case experimentGroup
  case planetImageScaleFactor
}

class RCValues {
  
  static let sharedInstance = RCValues()

  var loadingDoneCallback: (() -> Void)?
  var fetchComplete = false

  private init() {
    loadDefaultValues()
    fetchCloudValues()
  }
  
  func loadDefaultValues() {
    let appDefaults: [String: Any?] = [
      ValueKey.bigLabelColor.rawValue: "#FFFFFF66",
      ValueKey.appPrimaryColor.rawValue: "#FBB03B",
      ValueKey.navBarBackground.rawValue: "#535E66",
      ValueKey.navTintColor.rawValue: "#FBB03B",
      ValueKey.detailTitleColor.rawValue: "#FFFFFF",
      ValueKey.detailInfoColor.rawValue: "#CCCCCC",
      ValueKey.subscribeBannerText.rawValue: "Like Planet Tour?",
      ValueKey.subscribeBannerButton.rawValue: "Get our newsletter!",
      ValueKey.subscribeVCText.rawValue: "Want more astronomy facts? Sign up for our newsletter!",
      ValueKey.subscribeVCButton.rawValue: "Subscribe",
      ValueKey.shouldWeIncludePluto.rawValue: false,
      ValueKey.experimentGroup.rawValue: "default",
      ValueKey.planetImageScaleFactor.rawValue: 0.33
    ]
    RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
  }

  
  func fetchCloudValues() {
    // 1
    // WARNING: Don't actually do this in production!
    let fetchDuration: TimeInterval = 0
    activateDebugMode()

    RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) { status, error in
      
      if let error = error {
        print("Uh-oh. Got an error fetching remote values \(error)")
        return
      }
      
      // 2
      RemoteConfig.remoteConfig().activateFetched()
      print("Retrieved values from the cloud!")
      
      let appPrimaryColorString = RemoteConfig.remoteConfig()
        .configValue(forKey: "appPrimaryColor")
        .stringValue ?? "undefined"
      print("Our app's primary color is \(appPrimaryColorString)")
      
      let appPrimaryColorString2 = RemoteConfig.remoteConfig()
        .configValue(forKey: "AAA")
        .stringValue ?? "undefined"
      print("Our app's primary color is \(appPrimaryColorString2)")
      
      self.fetchComplete = true
      self.loadingDoneCallback?()

    }
  }
  
  func color(forKey key: ValueKey) -> UIColor {
    let colorAsHexString = RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? "#FFFFFF"
    let convertedColor = UIColor(colorAsHexString)
    return convertedColor
  }
  
  func bool(forKey key: ValueKey) -> Bool {
    return RemoteConfig.remoteConfig()[key.rawValue].boolValue
  }
  
  func string(forKey key: ValueKey) -> String {
    return RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
  }
  
  func double(forKey key: ValueKey) -> Double {
    if let numberValue = RemoteConfig.remoteConfig()[key.rawValue].numberValue {
      return numberValue.doubleValue
    } else {
      return 0.0
    }
  }

  func activateDebugMode() {
    if let debugSettings = RemoteConfigSettings(developerModeEnabled: true) {
      RemoteConfig.remoteConfig().configSettings = debugSettings
    }
  }

}
