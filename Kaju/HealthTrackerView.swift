import SwiftUI

struct HealthTrackerView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Track Kaju's health here 🩺")
                    .font(.title2)
            }
            .navigationTitle("Health Tracker")
        }
    }
}
