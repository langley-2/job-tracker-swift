import SwiftUI

struct EditJobView: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    @Binding var isPresented: Bool
    
    @State private var jobTitle: String
    @State private var orgName: String
    @State private var jobLink: String
    @State private var contactName: String
    @State private var isResearched: Bool
    @State private var hasReachedOut: Bool
    @State private var hasApplied: Bool
    @State private var status: JobStatus
    @State private var notes: String
    
    init(job: Job, jobStore: JobStore, isPresented: Binding<Bool>) {
        self.job = job
        self.jobStore = jobStore
        self._isPresented = isPresented
        
        // Initialize state variables with job values
        self._jobTitle = State(initialValue: job.jobTitle)
        self._orgName = State(initialValue: job.orgName)
        self._jobLink = State(initialValue: job.jobLink?.absoluteString ?? "")
        self._contactName = State(initialValue: job.contactName)
        self._isResearched = State(initialValue: job.isResearched)
        self._hasReachedOut = State(initialValue: job.hasReachedOut)
        self._hasApplied = State(initialValue: job.hasApplied)
        self._status = State(initialValue: job.status)
        self._notes = State(initialValue: job.notes)
    }
    
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
            .navigationTitle("Edit Job")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveJob()
                        isPresented = false
                    }
                    .disabled(jobTitle.isEmpty || orgName.isEmpty)
                }
            }
        }
    }
    
    private func saveJob() {
        // Create a new job instance with updated values
        let updatedJob = Job(
            id: job.id,
            jobTitle: jobTitle,
            orgName: orgName,
            jobLink: jobLink.isEmpty ? nil : URL(string: jobLink),
            contactName: contactName,
            isResearched: isResearched,
            hasReachedOut: hasReachedOut,
            hasApplied: hasApplied,
            status: status,
            notes: notes,
            date: job.date
        )
        
        jobStore.updateJob(updatedJob)
    }
}
