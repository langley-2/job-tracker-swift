import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            JobsListView()
                .tabItem {
                    Label("Jobs", systemImage: "briefcase.fill")
                }
            
            StatisticsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
