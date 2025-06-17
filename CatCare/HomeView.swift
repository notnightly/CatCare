import SwiftUI

struct HomeView: View {
    @AppStorage("lastCleaned") private var lastCleaned: Double = 0

    var cleanedRecently: Bool {
        guard lastCleaned > 0 else { return false }
        let lastCleanedDate = Date(timeIntervalSince1970: lastCleaned)
        return Date().timeIntervalSince(lastCleanedDate) < 86400
    }

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                HStack(spacing: 20) {
                    NavigationLink(destination: HealthTrackerView()) {
                        StatCard(title: "Health", value: "✔️", color: .pink)
                    }
                    StatCard(title: "Meals", value: "2 / 3", color: .orange)
                }

                HStack(spacing: 20) {
                    if cleanedRecently {
                        NavigationLink(destination: LitterBoxView()) {
                            StatCard(title: "Litter", value: "Clean", color: .green)
                        }
                    } else {
                        NavigationLink(destination: LitterBoxView()) {
                            StatCard(title: "Litter", value: "Not clean", color: .green)
                        }
                    }
                    

                    NavigationLink(destination: MoodDiaryView()) {
                        StatCard(title: "Mood", value: "😸 Happy", color: .blue)
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack {
            Text(value)
                .font(.title)
                .bold()
                .padding(.bottom, 2)

            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(16)
    }
}
