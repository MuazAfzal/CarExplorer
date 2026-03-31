import AppIntents
import Foundation

struct FindNearbyDealersIntent: AppIntent {
    static var title: LocalizedStringResource = "Find Nearby Dealers"
    static var description = IntentDescription("Open CarExplorer and show nearby dealers.")

    @Parameter(title: "Postcode")
    var postcode: String

    static var openAppWhenRun: Bool = true

    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        AppNavigation.shared.selectedTab = .dealers
        AppNavigation.shared.dealerPostcode = postcode.uppercased()

        return .result(
            dialog: IntentDialog("Opening nearby dealers in CarExplorer.")
        )
    }
}
