import SwiftUI
import UserNotifications

@main
struct KajuApp: App {
    init() {
        requestNotificationPermission()
        // Optional: schedule initial notification
        let hour = UserDefaults.standard.integer(forKey: "reminderHour")
        let minute = UserDefaults.standard.integer(forKey: "reminderMinute")
        NotificationManager.shared.scheduleLitterReminder(hour: hour, minute: minute)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if granted {
                print("✅ Notification permission granted")
            } else {
                print("❌ Notification permission denied")
            }
        }
    }
}
