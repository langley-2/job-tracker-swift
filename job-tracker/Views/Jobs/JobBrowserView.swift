//
//  JobBrowserView.swift
//  job-tracker
//
//  Created by Langley Millard on 5/5/2025.
//

import SwiftUI

struct JobBrowserView: View {
    @State private var searchQuery: String = ""
    @State private var jobs: [Job] = []
    @ObservedObject var jobStore: JobStore
    
    var filteredJobs: [Job] {
        guard !searchQuery.isEmpty else { return jobs }
        return jobs.filter {
            $0.jobTitle.localizedCaseInsensitiveContains(searchQuery) ||
            $0.orgName.localizedCaseInsensitiveContains(searchQuery)
        }
    }
    
    var body: some View {
        // Removed NavigationView from here
        VStack {
            // Search Bar
            TextField("Search jobs or companies", text: $searchQuery)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // Job List
            List(filteredJobs) { job in
                NavigationLink(destination: JobPreviewView(job: job, jobStore: jobStore)) {
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
        }
        .navigationTitle("Browse Jobs")
        .onAppear(perform: loadSampleJobs)
    }


    private func loadSampleJobs() {
        // These jobs represent external listings, not saved in your JobStore
        jobs = [
            Job(
                jobTitle: "Machine Learning Engineer",
                orgName: "OpenAI",
                jobLink: URL(string: "https://openai.com/careers/machine-learning-engineer"),
                contactName: "Sam Altman",
                description: "Build cutting-edge AI models and contribute to research that shapes the future of artificial intelligence."
            ),
            Job(
                jobTitle: "Product Designer",
                orgName: "Figma",
                jobLink: URL(string: "https://www.figma.com/careers/product-designer"),
                contactName: "Dylan Field",
                description: "Design collaborative UI/UX tools that empower creators around the world to build visually stunning products."
            ),
            Job(
                jobTitle: "Cloud Infrastructure Engineer",
                orgName: "HashiCorp",
                jobLink: URL(string: "https://www.hashicorp.com/careers/cloud-infrastructure-engineer"),
                contactName: "Armon Dadgar",
                description: "Maintain and scale infrastructure-as-code platforms like Terraform and Nomad for global cloud deployments."
            ),
            Job(
                jobTitle: "Full Stack Developer",
                orgName: "Canva",
                jobLink: URL(string: "https://www.canva.com/careers/full-stack-developer"),
                contactName: "Melanie Perkins",
                description: "Develop frontend and backend systems for a design platform used by over 100 million users worldwide."
            ),
            Job(
                jobTitle: "Security Analyst",
                orgName: "Atlassian",
                jobLink: URL(string: "https://www.atlassian.com/company/careers/security-analyst"),
                contactName: "Scott Farquhar",
                description: "Ensure the security and compliance of Jira and Confluence by monitoring threats and improving detection systems."
            )
        ]

    }
}

#Preview {
    JobBrowserView(jobStore: JobStore())
}
