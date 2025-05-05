import SwiftUI

struct JobPreviewView: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false  // Add this state variable
    
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
                }
                .padding(.bottom)
                
                // Job details section
                if let jobLink = job.jobLink {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Job Link")
                            .font(.headline)
                        
                        Link(jobLink.absoluteString, destination: jobLink)
                            .lineLimit(1)
                            .truncationMode(.middle)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Description section - only shown if description exists
                if let description = job.description, !description.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Description")
                            .font(.headline)
                        
                        Text(description)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                }
                
                Spacer()
                
                // Save button
                Button(action: {
                    saveJobAsDiscovered()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Save to My Jobs")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert) {  // Add the alert here
            Alert(
                title: Text("Job Saved"),
                message: Text("This job has been added to your job list."),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    private func saveJobAsDiscovered() {
        // Create a modified copy using the `updated()` method
        let newJob = job.updated(status: .discovered)
        
        // Add to job store
        jobStore.addJob(newJob)
        
        // Show alert
        showingAlert = true // Trigger the alert
    }
}
