import Foundation

// Added the NSLocalizedString functionality.
extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }

    /* Method should be applied on format string, returns default "No Value" localized
    string in case if interpolationValue is nil */
    func getLocalizedStringFromFormat<T>(_ interpolationValue: T?) -> String {
        if let interpolationValue = interpolationValue, let value = interpolationValue as? CVarArg {
            return String(format: self.localized, value)
        }
        return "No value".localized
    }
}
