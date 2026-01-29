import Foundation
import AppKit

@MainActor
class LicenseViewModel: ObservableObject {
    enum LicenseState: Equatable {
        case licensed
    }

    @Published private(set) var licenseState: LicenseState = .licensed

    var canUseApp: Bool {
        return true
    }
}
