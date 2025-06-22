import UserNotifications
import SwiftUI

class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    func scheduleLitterReminder(hour: Int, minute: Int) {
        // removes old notif
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["litterReminder"])


        // build notification
        let content = UNMutableNotificationContent()
        content.title = "Kaju's Litterbox"
        content.body = "Don't forget to clean Kaju’s litterbox!"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "litterReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
        // i thank ai for this
        print("Reminder scheduled at \(hour):\(String(format: "%02d", minute))")
    }
}
