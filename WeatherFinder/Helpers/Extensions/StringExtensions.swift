import Foundation


// Added the NSLocalizedString functionality.
extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

// Gets a value from info.plist from key (key is a value of current string)
extension String {
    var valueFromInfoPlist: String? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: self) as? String else {
            return nil
        }
        return value
    }
}
