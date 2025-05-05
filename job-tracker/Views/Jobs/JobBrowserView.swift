import SwiftUI

struct JobBrowserView: View {
    @State private var searchQuery: String = ""
    @State private var jobs: [Job] = []
    
    var filteredJobs: [Job] {
        guard !searchQuery.isEmpty else { return jobs }
        return jobs.filter {
            $0.jobTitle.localizedCaseInsensitiveContains(searchQuery) ||
            $0.orgName.localizedCaseInsensitiveContains(searchQuery)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search jobs or companies", text: $searchQuery)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Job List
                List(filteredJobs) { job in
                    VStack(alignment: .leading) {
                        Text(job.jobTitle)
                            .font(.headline)
                        Text(job.orgName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        if let url = job.jobLink {
                            Link("View Listing", destination: url)
                                .font(.caption)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Browse Jobs")
            .onAppear(perform: loadSampleJobs)
        }
    }

    private func loadSampleJobs() {
        // Placeholder: you’d replace this with real API data or a JSON file
        jobs = [
            Job(jobTitle: "iOS Developer", orgName: "Tech Corp", jobLink: "https://example.com/job1"),
            Job(jobTitle: "Frontend Engineer", orgName: "Webify", jobLink: "https://example.com/job2"),
            Job(jobTitle: "Backend Developer", orgName: "ServerStack", jobLink: nil)
        ]
    }
}

#Preview {
    JobBrowserView()
}
