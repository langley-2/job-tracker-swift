import SwiftUI

struct SettingsView: View {
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = true
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")) {
                    TextField("Your Name", text: $userName)
                        .focused($isTextFieldFocused)
                }
                
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    
                    if notificationsEnabled {
                        Toggle("Application Reminders", isOn: .constant(true))
                        Toggle("Interview Reminders", isOn: .constant(true))
                    }
                }
                
                Section(header: Text("Data")) {
                    Button("Export Data") {
                        // Export functionality would go here
                    }
                    
                    Button("Clear All Jobs") {
                        // Clear data with confirmation
                    }
                    .foregroundColor(.red)
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        isTextFieldFocused = false
                    }
                }
            }
            // This gesture recognizer dismisses the keyboard when tapping elsewhere
            .onTapGesture {
                isTextFieldFocused = false
            }
        }
    }
}
