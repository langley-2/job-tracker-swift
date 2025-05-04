import SwiftUI

struct InterviewingView: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    @State private var showingStatusUpdate = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Section(header: Text("Interview Process").font(.headline)) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Status: In interview process")
                    Text("Last update: \(job.date, formatter: dateFormatter)")
                    // In a real app, you'd track interview stages
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            Section(header: Text("Preparation Tips").font(.headline)) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("• Research the company thoroughly")
                    Text("• Practice common interview questions")
                    Text("• Prepare questions to ask the interviewer")
                    Text("• Review your resume and the job description")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            // In a real app, you could add an interview timeline here
            
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
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
