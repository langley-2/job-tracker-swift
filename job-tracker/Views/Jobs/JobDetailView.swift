import SwiftUI

struct JobDetailView: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    @State private var isEditing = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header info
                VStack(alignment: .leading, spacing: 8) {
                    Text(job.jobTitle)
                        .font(.title)
                        .bold()
                    
                    Text(job.orgName)
                        .font(.title2)
                    
                    HStack {
                        Image(systemName: job.status.systemImage)
                            .foregroundColor(job.status.color)
                        Text(job.status.rawValue)
                            .foregroundColor(job.status.color)
                    }
                    .font(.headline)
                    .padding(.top, 4)
                }
                .padding(.bottom)
                
                // Job details section
                Group {
                    JobDetailsSection(job: job)
                    
                    Divider()
                    
                    ProgressSection(job: job, jobStore: jobStore)
                    
                    Divider()
                    
                    // Notes section
                    if !job.notes.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Notes")
                                .font(.headline)
                            
                            Text(job.notes)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                        }
                        
                        Divider()
                    }
                    
                    // Status-specific view
                    StatusSpecificView(job: job, jobStore: jobStore)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    isEditing = true
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            EditJobView(job: job, jobStore: jobStore, isPresented: $isEditing)
        }
    }
}

struct JobDetailsSection: View {
    let job: Job
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Job Details")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 8) {
                if !job.contactName.isEmpty {
                    HStack {
                        Text("Contact:")
                        Spacer()
                        Text(job.contactName)
                    }
                }
                
                if let jobLink = job.jobLink {
                    HStack {
                        Text("Job Link:")
                        Spacer()
                        Link(jobLink.absoluteString, destination: jobLink)
                            .lineLimit(1)
                            .truncationMode(.middle)
                    }
                }
                
                HStack {
                    Text("Added:")
                    Spacer()
                    Text(job.date, format: .dateTime.month().day().year())
                }
                
                // Add description if it exists
                if let description = job.description, !description.isEmpty {
                    Divider()
                        .padding(.vertical, 4)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Description:")
                            .fontWeight(.medium)
                        Text(description)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

struct ProgressSection: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Progress")
                .font(.headline)
            
            VStack(spacing: 4) {
                ProgressRow(
                    title: "Research",
                    isCompleted: job.isResearched,
                    action: {
                        let updatedJob = job.updated(isResearched: !job.isResearched)
                        jobStore.updateJob(updatedJob)
                    }
                )
                
                ProgressRow(
                    title: "Reached Out",
                    isCompleted: job.hasReachedOut,
                    action: {
                        let updatedJob = job.updated(hasReachedOut: !job.hasReachedOut)
                        jobStore.updateJob(updatedJob)
                    }
                )
                
                ProgressRow(
                    title: "Applied",
                    isCompleted: job.hasApplied,
                    action: {
                        let updatedJob = job.updated(hasApplied: !job.hasApplied)
                        jobStore.updateJob(updatedJob)
                    }
                )
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

struct ProgressRow: View {
    let title: String
    let isCompleted: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isCompleted ? .green : .gray)
                Text(title)
                Spacer()
                Text(isCompleted ? "Completed" : "Pending")
                    .font(.caption)
                    .foregroundColor(isCompleted ? .green : .gray)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .padding(.vertical, 8)
    }
}
