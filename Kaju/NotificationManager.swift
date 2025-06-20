import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            if granted {
                print("✅ Notification permission granted")
            }
        }
    }

    func scheduleLitterReminder() {
        let content = UNMutableNotificationContent()
        content.title = "Litter Reminder!"
        content.body = "Time to clean Kaju's litter box!"
        content.sound = .defaultCritical

        var dateComponents = DateComponents()
        dateComponents.hour = 20 // 10 pm
        dateComponents.minute = 30

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "litterReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}
