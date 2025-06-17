import SwiftUI

@main
struct KajuCareApp: App {
    init() {
        NotificationManager.shared.requestPermission()
        NotificationManager.shared.scheduleLitterReminder()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
