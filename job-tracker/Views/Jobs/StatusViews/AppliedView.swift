import SwiftUI

struct AppliedView: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    @State private var showingStatusUpdate = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Section(header: Text("Application Summary").font(.headline)) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Date Applied: \(job.date, formatter: dateFormatter)")
                    Text("Application Status: Submitted")
                    // Additional details would go here
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            Section(header: Text("Next Steps").font(.headline)) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("• Wait for initial response")
                    Text("• Prepare for potential screening call")
                    Text("• Review company info and job details")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            Spacer()
            
            Button("Update Status") {
                showingStatusUpdate = true
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .actionSheet(isPresented: $showingStatusUpdate) {
                ActionSheet(
                    title: Text("Update Job Status"),
                    message: Text("Select the new status for this application"),
                    buttons: [
                        .default(Text("Interviewing")) {
                            updateJobStatus(.interviewing)
                        },
                        .default(Text("Offer")) {
                            updateJobStatus(.offer)
                        },
                        .destructive(Text("Rejected")) {
                            updateJobStatus(.rejected)
                        },
                        .cancel()
                    ]
                )
            }
        }
    }
    
    private func updateJobStatus(_ status: JobStatus) {
        // Use the updated() method from the Job struct
        let updatedJob = job.updated(status: status)
        jobStore.updateJob(updatedJob)
        
        // Or if you don't have the updated() method, use this approach instead:
        /*
        let updatedJob = Job(
            id: job.id,
            jobTitle: job.jobTitle,
            orgName: job.orgName,
            jobLink: job.jobLink?.absoluteString,
            contactName: job.contactName,
            isResearched: job.isResearched,
            hasReachedOut: job.hasReachedOut,
            hasApplied: job.hasApplied,
            status: status,
            notes: job.notes,
            date: job.date
        )
        jobStore.updateJob(updatedJob)
        */
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
