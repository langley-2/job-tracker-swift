import SwiftUI

struct JobDetailView: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    @State private var isEditing = false
    
    // Helper function to determine status step index
    private func statusStepIndex(_ status: JobStatus) -> Int {
        switch status {
        case .discovered: return 0
        case .researching: return 1
        case .outreach: return 2
        case .applied: return 3
        case .interviewing: return 4
        case .offer: return 5
        case .accepted, .rejected, .closed: return 6
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Status Progress Bar
                VStack(alignment: .leading, spacing: 8) {
                    Text("Application Progress")
                        .font(.headline)
                    
                    // Current Status Only
                    HStack {
                        Text(job.status.rawValue)
                            .font(.headline)
                            .foregroundColor(.green)
                        
                        Spacer()
                        
                        Text("(\(job.daysInStatus) days)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    // Current Status Indicator
                    HStack(spacing: 8) {
                        ForEach(0..<7) { step in
                            Circle()
                                .fill(step <= statusStepIndex(job.status) ? Color.green : Color.gray.opacity(0.3))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .padding(.bottom)
                
                // Header info
                VStack(alignment: .leading, spacing: 8) {
                    Text(job.jobTitle)
                        .font(.title)
                        .bold()
                    
                    Text(job.orgName)
                        .font(.title2)
                }
                .padding(.bottom)
                
                // Combined Job Details & Application Tracking
                VStack(alignment: .leading, spacing: 12) {
                    Text("Job Information")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Contact info
                        if !job.contactName.isEmpty {
                            HStack {
                                Text("Contact:")
                                Spacer()
                                Text(job.contactName)
                            }
                        }
                        
                        // Job Link
                        if let jobLink = job.jobLink {
                            HStack {
                                Text("Job Link:")
                                Spacer()
                                Link(jobLink.absoluteString, destination: jobLink)
                                    .lineLimit(1)
                                    .truncationMode(.middle)
                            }
                        }
                        
                        // Added date
                        HStack {
                            Text("Added:")
                            Spacer()
                            Text(job.date, format: .dateTime.month().day().year())
                        }
                        
                        // Deadline (simplified timeline)
                        if let deadline = job.deadlineDate {
                            HStack {
                                Text("Deadline:")
                                Spacer()
                                Text(deadline, format: .dateTime.month().day().year())
                                Text(isPastDeadline(deadline) ? "(Passed)" : "")
                                    .foregroundColor(isPastDeadline(deadline) ? .red : .primary)
                            }
                        }
                        
                        // Interest Level with circles
                        HStack {
                            Text("Interest Level:")
                            Spacer()
                            HStack(spacing: 4) {
                                ForEach(0..<4) { level in
                                    Circle()
                                        .fill(level <= job.interestLevel ? Color.green : Color.gray.opacity(0.3))
                                        .frame(width: 8, height: 8)
                                }
                            }
                        }
                        
                        // Simplified Referral Status
                        if job.hasReferral {
                            HStack {
                                Text("Referral:")
                                Spacer()
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 8, height: 8)
                                if !job.contactName.isEmpty {
                                    Text(job.contactName)
                                }
                            }
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
    
    // Helper to check if a deadline has passed
    private func isPastDeadline(_ date: Date) -> Bool {
        return date < Date()
    }
}
