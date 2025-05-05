import SwiftUI

struct JobsListView: View {
    @ObservedObject var jobStore: JobStore
    @State private var showingAddJob = false
    
    var body: some View {
        List(jobStore.jobs) { job in
            NavigationLink(destination: JobDetailView(job: job, jobStore: jobStore)) {
                JobRowView(job: job)
            }
        }
        .navigationTitle("My Job Applications")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddJob = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddJob) {
            AddJobView(jobStore: jobStore)
        }
    }
}
