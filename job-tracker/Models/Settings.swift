import SwiftUI
import Combine

// MARK: - Models

enum JobLocationType: String, CaseIterable, Identifiable, Codable {
    case onsite = "On-site"
    case remote = "Remote"
    case hybrid = "Hybrid"
    case any = "Any"
    
    var id: String { self.rawValue }
}

struct AISettings: Codable {
    var enabled: Bool = true
    var chatGPTEnabled: Bool = false
    var apiKey: String = ""
    var modelPreference: String = "gpt-4"
    var jobMatchingEnabled: Bool = true
    var saveHistory: Bool = true
    var skillsAnalysisEnabled: Bool = true
}

struct JobPreferences: Codable {
    var locationPreference: JobLocationType = .hybrid
    var minSalary: Double = 50000
    var maxSalary: Double = 150000
    var industries: [String] = []
    var roles: [String] = []
    var experienceLevel: String = "Mid-level"
    var keywords: [String] = []
}

struct NotificationSettings: Codable {
    var enabled: Bool = true
    var jobMatchAlerts: Bool = true
    var applicationReminders: Bool = true
    var interviewReminders: Bool = true
    var dailyJobDigest: Bool = false
    var emailNotifications: Bool = true
    var pushNotifications: Bool = true
}

struct AppearanceSettings: Codable {
    var darkModeEnabled: Bool = false
    var accentColor: String = "blue"
    var fontSize: Double = 1.0 // Multiplier for base font size
}

struct UserProfile: Codable {
    var name: String = ""
    var professionalTitle: String = ""
    var email: String = ""
    var phone: String = ""
    var linkedInConnected: Bool = false
    var linkedInProfileId: String = ""
    var resumeUploaded: Bool = false
    var resumeLastUpdated: Date?
}

// MARK: - Main Settings Model

struct Settings: Codable {
    var userProfile = UserProfile()
    var aiSettings = AISettings()
    var jobPreferences = JobPreferences()
    var notificationSettings = NotificationSettings()
    var appearanceSettings = AppearanceSettings()
}
