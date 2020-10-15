import Foundation


// Added the NSLocalizedString functionality.
extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
