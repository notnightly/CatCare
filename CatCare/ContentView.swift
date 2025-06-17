import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            HealthTrackerView()
                .tabItem {
                    Label("Health", systemImage: "heart.text.square")
                }

            FeedingScheduleView()
                .tabItem {
                    Label("Feeding", systemImage: "calendar")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
            LitterBoxView()
                .tabItem {
                    Label("Litter", systemImage: "trash")
                }
        }
    }
} 

#Preview {
    ContentView()
}

