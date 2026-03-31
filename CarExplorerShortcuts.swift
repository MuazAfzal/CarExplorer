import AppIntents

struct CarExplorerShortcuts: AppShortcutsProvider {

    static var appShortcuts: [AppShortcut] {
        var shortcuts: [AppShortcut] = []

        let dealerShortcut = AppShortcut(
            intent: FindNearbyDealersIntent(),
            phrases: [
                "Find nearby dealers in \(.applicationName)",
                "Show nearby dealers in \(.applicationName)",
                "Open dealers in \(.applicationName)"
            ],
            shortTitle: "Nearby Dealers",
            systemImageName: "map.fill"
        )

        shortcuts.append(dealerShortcut)

        return shortcuts
    }
}
