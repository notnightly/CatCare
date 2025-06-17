import SwiftUI

struct LitterBoxView: View {
    @AppStorage("lastCleaned") private var lastCleaned: Double = 0;
    @AppStorage("cleaningHistory") private var cleaningHistoryRaw: String = "";

    var lastCleanedDate: Date? {
        lastCleaned == 0 ? nil : Date(timeIntervalSince1970: lastCleaned)
    }
     
    var timeAgo: String {
        guard let date = lastCleanedDate else { return "Never cleaned" }
        let interval = Date().timeIntervalSince(date)
        let hours = Int(interval / 3600)
        let minutes = Int((interval.truncatingRemainder(dividingBy: 3600)) / 60)
        return hours > 0 ? "\(hours)h \(minutes)m ago" : "\(minutes)m ago"
    }

    var showWarning: Bool {
        guard let date = lastCleanedDate else { return false }
        return Date().timeIntervalSince(date) > 86400 // 24 hours
    }

    var cleaningHistory: [Date] {
        cleaningHistoryRaw
            .split(separator: "|")
            .compactMap { Double($0).map(Date.init(timeIntervalSince1970:)) }
            .sorted(by: >)
    }

    func addToHistory(_ date: Date) {
        var all = cleaningHistory.map { $0.timeIntervalSince1970 }
        all.insert(date.timeIntervalSince1970, at: 0)
        if all.count > 20 { all.removeLast() } // keep max 20
        cleaningHistoryRaw = all.map { String(Int($0)) }.joined(separator: "|")
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("🧹 Litterbox Cleaning Tracker")
                    .font(.title2)
                    .bold()

                Group {
                    Text("Last Cleaned:")
                        .font(.headline)

                    if let date = lastCleanedDate {
                        Text(date.formatted(date: .abbreviated, time: .shortened))
                            .foregroundColor(.green)
                        Text("⏱ \(timeAgo)")
                            .foregroundColor(.gray)
                    } else {
                        Text("Not cleaned yet")
                            .foregroundColor(.red)
                    }
                }

                if showWarning {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                        Text("Not cleaned in 24 hours!")
                    }
                    .padding()
                    .background(Color.red.opacity(0.15))
                    .foregroundColor(.red)
                    .cornerRadius(12)
                }

                Button(action: {
                    let now = Date()
                    lastCleaned = now.timeIntervalSince1970
                    addToHistory(now)
                }) {
                    Label("Mark as Cleaned", systemImage: "checkmark.seal.fill")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.15))
                        .cornerRadius(14)
                }

                Divider().padding(.vertical, 10)

                Text("Cleaning History")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                List(cleaningHistory, id: \.self) { date in
                    HStack {
                        Text(date.formatted(date: .abbreviated, time: .shortened))
                        Spacer()
                        Text(timeAgoString(since: date))
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                }
                .frame(maxHeight: 250)
                .listStyle(.plain)

                Spacer()
            }
            .padding()
            .navigationTitle("Litterbox")
        }
    }

    func timeAgoString(since date: Date) -> String {
        let interval = Date().timeIntervalSince(date)
        let hours = Int(interval / 3600)
        let minutes = Int((interval.truncatingRemainder(dividingBy: 3600)) / 60)
        return hours > 0 ? "\(hours)h \(minutes)m ago" : "\(minutes)m ago"
    }
    
}
