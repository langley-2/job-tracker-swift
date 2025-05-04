import SwiftUI

@main
struct JobTrackerApp: App {
    // Create a single shared instance of JobStore
    @StateObject private var jobStore = JobStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(jobStore) // Pass it to the entire view hierarchy
        }
    }
}
