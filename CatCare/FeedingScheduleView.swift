import SwiftUI

struct FeedingScheduleView: View {
    func fed(fedText: String) -> Text {
        return Text(fedText);
    }
    @State private var isFed = false
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("Kaju's Feeding Times 🍽")
                    .font(.title2)
            }
            .navigationTitle("Feeding Schedule")
            Button(action: {
                isFed = true
            }, label: {
                Text("Feed kaju")
            })
            if isFed {
                            Text("😺 Kaju is fed!")
                                .font(.headline)
                                .foregroundColor(.green)
                                .transition(.opacity)
                        }
        }
    }
}
