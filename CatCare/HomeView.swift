import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome, Kaju 🐾")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)

                Text("Here's how Kaju is doing today:")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                HStack(spacing: 20) {
                    StatCard(title: "Health", value: "✔️", color: .pink)
                    StatCard(title: "Meals", value: "2 / 3", color: .orange)
                }

                HStack(spacing: 20) {
                    StatCard(title: "Poop", value: "💩 Done", color: .green)

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
