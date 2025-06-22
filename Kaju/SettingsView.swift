import SwiftUI

struct SettingsView: View {
    
    @AppStorage("reminderHour") private var reminderHour: Int = 21
    @AppStorage("reminderMinute") private var reminderMinute: Int = 0

    private var reminderTimeBinding: Binding<Date> {
        Binding<Date>(
            get: {
                let comps = DateComponents(hour: reminderHour, minute: reminderMinute)
                return Calendar.current.date(from: comps) ?? Date()
            },
            set: {
                let comps = Calendar.current.dateComponents([.hour, .minute], from: $0)
                reminderHour = comps.hour ?? 21
                reminderMinute = comps.minute ?? 0
            }
        )
    }
    var body: some View {
        NavigationStack {
            
            VStack {
                
                Section(header: Text("Litterbox Reminder Time")) {
                    DatePicker("Remind me at", selection: reminderTimeBinding, displayedComponents: .hourAndMinute)
                }

            }
            .navigationTitle("Settings")
        }
    }
}

