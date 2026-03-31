import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var navigation = AppNavigation.shared
    @AppStorage("selectedAppearance") private var selectedAppearance: String = "system"

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
            } else if !isLoggedIn {
                LoginView(isLoggedIn: $isLoggedIn)
            } else {
                TabView(selection: $navigation.selectedTab) {
                    
                    HomeView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .tag(AppTab.home)
                    
                    NavigationStack {
                        SearchView()
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(AppTab.search)
                    
                    NavigationStack {
                        DealersView(postcode: navigation.dealerPostcode)
                    }
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Dealers")
                    }
                    .tag(AppTab.dealers)
                    
                    NavigationStack {
                        SavedView()
                    }
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Saved")
                    }
                    .tag(AppTab.saved)
                    
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gearshape.fill")
                            Text("Settings")
                        }
                }
            }
        }
        .preferredColorScheme(appColorScheme)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showSplash = false
            }
        }
    }

    var appColorScheme: ColorScheme? {
        switch selectedAppearance {
        case "light": return .light
        case "dark": return .dark
        default: return nil
        }
    }
}
