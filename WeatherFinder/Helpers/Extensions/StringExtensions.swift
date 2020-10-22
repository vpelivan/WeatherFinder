import Foundation


// Added the NSLocalizedString functionality.
extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    /* Method should be applied on format string, returns default "No Value" localized
    string in case if interpolationValue is nil */
    func getLocalizedStringFromFormat<T>(_ interpolationValue: T?) -> String {
        if let interpolationValue = interpolationValue {
            return String(format: self.localized, interpolationValue as! CVarArg)
        }
        return "No value".localized
    }
}
