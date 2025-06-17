import SwiftUI

struct MoodDiaryView: View {
    @State private var moodNote = ""
    @State private var moodEmoji = "😸"

    var body: some View {
        VStack(spacing: 20) {
            Text("Kaju's Mood Diary")
                .font(.title)
                .fontWeight(.semibold)

            Picker("Mood", selection: $moodEmoji) {
                Text("😸 Happy").tag("😸")
                Text("😿 Sad").tag("😿")
                Text("😾 Angry").tag("😾")
                Text("😻 Cuddly").tag("😻")
            }
            .pickerStyle(.segmented)

            TextField("Notes about Kaju's mood...", text: $moodNote)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Spacer()
        }
        .padding()
        .navigationTitle("Mood Diary")
    }
}
