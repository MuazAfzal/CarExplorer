import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedAppearance") private var selectedAppearance: String = "system"
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = true
    @AppStorage("locationEnabled") private var locationEnabled: Bool = true

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 14) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 56, height: 56)
                            .clipShape(RoundedRectangle(cornerRadius: 14))

                        VStack(alignment: .leading, spacing: 4) {
                            Text("CarExplorer")
                                .font(.headline)

                            Text("Find affordable first cars with confidence")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 6)
                }

                Section("Appearance") {
                    Picker("Theme", selection: $selectedAppearance) {
                        Text("System").tag("system")
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }
                    .pickerStyle(.inline)
                }

                Section("Preferences") {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    Toggle("Enable Location Access", isOn: $locationEnabled)
                }

                Section("About") {
                    SettingsRow(title: "Version", value: "1.0.0")
                    SettingsRow(title: "Developer", value: "CarExplorer")
                    SettingsRow(title: "Support", value: "help@carexplorer.app")
                }
                
                Section {
                    Button("Log Out") {
                        UserDefaults.standard.set(false, forKey: "isLoggedIn")
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SettingsView()
}
