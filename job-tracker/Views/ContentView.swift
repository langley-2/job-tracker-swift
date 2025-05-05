import SwiftUI

struct ContentView: View {
    @StateObject private var jobStore = JobStore()
    
    var body: some View {
        TabView {
            NavigationView {  // Add NavigationView here
                JobsListView(jobStore: jobStore)
            }
            .tabItem {
                Label("Jobs", systemImage: "briefcase.fill")
            }

            NavigationView {  // Add NavigationView here
                StatisticsView(jobStore: jobStore)
            }
            .tabItem {
                Label("Stats", systemImage: "briefcase.fill")
            }

            NavigationView {  // And here
                JobBrowserView(jobStore: jobStore)
            }
            .tabItem {
                Label("Browse", systemImage: "magnifyingglass.circle.fill")
            }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
