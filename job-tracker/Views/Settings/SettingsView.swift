import SwiftUI

struct SettingsView: View {
    @StateObject private var settingsManager = SettingsManager()
    @FocusState private var isTextFieldFocused: Bool
    @State private var showDeleteAllDataAlert = false
    @Environment(\.colorScheme) var currentColorScheme
    
    var body: some View {
        NavigationView {
            Form {
                // MARK: - Profile Section
                Section(header: Text("Profile")) {
                    TextField("Your Name", text: $settingsManager.settings.userProfile.name)
                        .focused($isTextFieldFocused)
                    
                    TextField("Professional Title", text: $settingsManager.settings.userProfile.professionalTitle)
                        .focused($isTextFieldFocused)
                    
                    TextField("Email", text: $settingsManager.settings.userProfile.email)
                        .focused($isTextFieldFocused)
                        .keyboardType(.emailAddress)
                    
                    TextField("Phone", text: $settingsManager.settings.userProfile.phone)
                        .focused($isTextFieldFocused)
                        .keyboardType(.phonePad)
                }
                
                // MARK: - AI Integration Section (Simplified)
                Section(header: Text("AI Assistant")) {
                    HStack {
                        Text("ChatGPT Integration")
                        Spacer()
                        Text("Coming soon")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                   
                    
                   
                }
                
                // MARK: - Job Search Section (Simplified)
                Section(header: Text("Job Search")) {
                    HStack {
                        Text("Advanced job search features")
                        Spacer()
                        Text("Coming soon")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                // MARK: - Notifications
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $settingsManager.settings.notificationSettings.enabled)
                    
                    if settingsManager.settings.notificationSettings.enabled {
                        Toggle("Job Match Alerts", isOn: $settingsManager.settings.notificationSettings.jobMatchAlerts)
                        Toggle("Application Reminders", isOn: $settingsManager.settings.notificationSettings.applicationReminders)
                        Toggle("Interview Reminders", isOn: $settingsManager.settings.notificationSettings.interviewReminders)
                    }
                }
                
                // MARK: - Appearance
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $settingsManager.settings.appearanceSettings.darkModeEnabled)
                        .onChange(of: settingsManager.settings.appearanceSettings.darkModeEnabled) { newValue in
                            settingsManager.applyAppearanceSettings()
                        }
                }
                
                // MARK: - About
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    NavigationLink("Help & Support") {
                        VStack(spacing: 20) {
                            Text("Need help with your job search?")
                                .font(.headline)
                            
                            Text("Contact us at support@jobapp.com")
                                .font(.body)
                            
                            Button("Visit Our Website") {
                                // Open website
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                        .navigationTitle("Help & Support")
                    }
                    
                    NavigationLink("Terms of Service") {
                        ScrollView {
                            Text("Terms of service text would appear here.")
                                .padding()
                        }
                        .navigationTitle("Terms of Service")
                    }
                    
                    NavigationLink("Privacy Policy") {
                        ScrollView {
                            Text("Privacy policy text would appear here.")
                                .padding()
                        }
                        .navigationTitle("Privacy Policy")
                    }
                }
                
                // MARK: - Delete Data (Moved to bottom)
                Section {
                    Button("Delete All Data") {
                        showDeleteAllDataAlert = true
                    }
                    .foregroundColor(.red)
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
            .alert("Delete All Data", isPresented: $showDeleteAllDataAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    settingsManager.clearAllData()
                }
            } message: {
                Text("Are you sure you want to delete all your data? This action cannot be undone.")
            }
            .onAppear {
                // Set initial appearance based on saved settings
                settingsManager.applyAppearanceSettings()
            }
        }
    }
}
