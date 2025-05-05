import SwiftUI

struct AddJobView: View {
    @ObservedObject var jobStore: JobStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var jobTitle: String = ""
    @State private var orgName: String = ""
    @State private var jobLink: String = ""
    @State private var contactName: String = ""
    @State private var isResearched: Bool = false
    @State private var hasReachedOut: Bool = false
    @State private var hasApplied: Bool = false
    @State private var status: JobStatus = .discovered
    @State private var notes: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Job Details")) {
                    TextField("Job Title", text: $jobTitle)
                    TextField("Organization Name", text: $orgName)
                    TextField("Job Link (URL)", text: $jobLink)
                    TextField("Contact Name", text: $contactName)
                }
                
                Section(header: Text("Progress")) {
                    Toggle("Researched", isOn: $isResearched)
                    Toggle("Reached Out", isOn: $hasReachedOut)
                    Toggle("Applied", isOn: $hasApplied)
                }
                
                Section(header: Text("Status")) {
                    Picker("Status", selection: $status) {
                        ForEach(JobStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                }
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $notes)
                        .frame(minHeight: 100)
                }
            }
            .navigationTitle("Add New Job")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newJob = Job(
                            jobTitle: jobTitle,
                            orgName: orgName,
                            jobLink: jobLink.isEmpty ? nil : URL(string: jobLink),
                            contactName: contactName,
                            isResearched: isResearched,
                            hasReachedOut: hasReachedOut,
                            hasApplied: hasApplied,
                            status: status,
                            notes: notes
                        )
                        
                        jobStore.addJob(newJob)
                        dismiss()
                    }
                    .disabled(jobTitle.isEmpty || orgName.isEmpty)
                }
            }
        }
    }
}
