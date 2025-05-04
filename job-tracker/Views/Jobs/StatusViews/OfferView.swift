import SwiftUI

struct OfferView: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    @State private var showingStatusUpdate = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Section(header: Text("Offer Details").font(.headline)) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Status: Offer received")
                    Text("Date: \(job.date, formatter: dateFormatter)")
                    // In a real app, you'd include offer details
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            Section(header: Text("Next Steps").font(.headline)) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("• Review the offer details")
                    Text("• Consider negotiation options")
                    Text("• Make your decision")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            Spacer()
            
            HStack {
                Button("Accept Offer") {
                    let updatedJob = job.updated(status: .accepted)
                    jobStore.updateJob(updatedJob)
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                
                Button("Decline Offer") {
                    showingStatusUpdate = true
                }
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity)
            }
            .actionSheet(isPresented: $showingStatusUpdate) {
                ActionSheet(
                    title: Text("Decline Offer"),
                    message: Text("Are you sure you want to decline this offer?"),
                    buttons: [
                        .destructive(Text("Decline Offer")) {
                            let updatedJob = job.updated(status: .rejected)
                            jobStore.updateJob(updatedJob)
                        },
                        .cancel()
                    ]
                )
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
