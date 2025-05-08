import SwiftUI
import Combine

// This class manages the Settings model, handling loading, saving, and other operations
class SettingsManager: ObservableObject {
    // Published settings that will trigger UI updates
    @Published var settings = Settings()
    
    // Keys for UserDefaults
    enum Keys {
        static let settings = "userSettings"
    }
    
    // Cancellables set to store subscribers
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Load saved settings from UserDefaults
        loadSettings()
        
        // Set up publisher to save settings when they change
        setupPublisher()
    }
    
    // MARK: - Settings Management
    
    private func loadSettings() {
        if let data = UserDefaults.standard.data(forKey: Keys.settings),
           let loadedSettings = try? JSONDecoder().decode(Settings.self, from: data) {
            settings = loadedSettings
        }
    }
    
    // Changed to public for external access
    func saveSettings() {
        if let encoded = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(encoded, forKey: Keys.settings)
        }
    }
    
    private func setupPublisher() {
        // Set up publisher to save settings when they change
        $settings
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.saveSettings()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Helper Functions
    
    // Applies dark mode setting to the app
    func applyAppearanceSettings() {
        // For UIKit-based apps, you would use this:
        #if !EXTENSION
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.overrideUserInterfaceStyle = settings.appearanceSettings.darkModeEnabled ? .dark : .light
        }
        #endif
        
        // Note: For pure SwiftUI apps in iOS 14+, you would typically use the
        // preferredColorScheme environment modifier at the app level instead
    }
    
    // Renamed from deleteAccount to clearAllData to match UI
    func clearAllData() {
        // Reset all settings to defaults
        settings = Settings()
        
        // Save the reset state
        saveSettings()
        
        // Delete any cached jobs or application data
        // (In a real app, this would connect to your job data store)
        
        // Clear any saved documents or files
        // (Implementation depends on how you store files)
        
        // Clear any authentication tokens
        // (If you have sign-in functionality)
    }
}

// Bundle for exporting all user data
struct ExportBundle: Codable {
    let settings: Settings
    let exportDate: Date
}
