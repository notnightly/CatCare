import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Manage settings ⚙️")
                    .font(.title2)
            }
            .navigationTitle("Settings")
        }
    }
}

