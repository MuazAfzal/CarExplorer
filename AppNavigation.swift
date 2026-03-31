import Foundation
import Observation

enum AppTab: Hashable {
    case home
    case search
    case dealers
    case saved
}

@MainActor
@Observable
final class AppNavigation {
    static let shared = AppNavigation()

    var selectedTab: AppTab = .home
    var dealerPostcode: String = ""
}
