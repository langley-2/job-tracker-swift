import SwiftUI

struct EditJobView: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    @Binding var isPresented: Bool
    
    @State private var jobTitle: String
    @State private var orgName: String
    @State private var jobLink: String
    @State private var contactName: String
    @State private var interestLevel: Int
    @State private var hasReferral: Bool
    @State private var deadlineDate: Date?
    @State private var showDeadlinePicker = false
    @State private var status: JobStatus
    @State private var notes: String
    @State private var description: String?
    @State private var daysInStatus: Int
    
    init(job: Job, jobStore: JobStore, isPresented: Binding<Bool>) {
        self.job = job
        self.jobStore = jobStore
        self._isPresented = isPresented
        
        // Initialize state variables with job values
        self._jobTitle = State(initialValue: job.jobTitle)
        self._orgName = State(initialValue: job.orgName)
        self._jobLink = State(initialValue: job.jobLink?.absoluteString ?? "")
        self._contactName = State(initialValue: job.contactName)
        self._interestLevel = State(initialValue: job.interestLevel)
        self._hasReferral = State(initialValue: job.hasReferral)
        self._deadlineDate = State(initialValue: job.deadlineDate)
        self._status = State(initialValue: job.status)
        self._notes = State(initialValue: job.notes)
        self._description = State(initialValue: job.description)
        self._daysInStatus = State(initialValue: job.daysInStatus)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Job Details")) {
                    TextField("Job Title", text: $jobTitle)
                    TextField("Organization Name", text: $orgName)
                    TextField("Job Link (URL)", text: $jobLink)
                    TextField("Contact Name", text: $contactName)
                    
                    // Description field
                    VStack(alignment: .leading) {
                        Text("Job Description")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        ZStack(alignment: .topLeading) {
                            if let description = description, !description.isEmpty {
                                TextEditor(text: Binding(
                                    get: { description },
                                    set: { self.description = $0 }
                                ))
                                .frame(minHeight: 80)
                            } else {
                                TextEditor(text: Binding(
                                    get: { "" },
                                    set: { self.description = $0.isEmpty ? nil : $0 }
                                ))
                                .frame(minHeight: 80)
                                .overlay(
                                    Text("Optional job description")
                                        .foregroundColor(.gray)
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 8),
                                    alignment: .topLeading
                                )
                            }
                        }
                    }
                }
                
                Section(header: Text("Application Tracking")) {
                    // Interest Level Selector with green circles
                    VStack(alignment: .leading) {
                        Text("Interest Level")
                        
                        HStack {
                            ForEach(0..<4) { level in
                                Button(action: {
                                    interestLevel = level
                                }) {
                                    Circle()
                                        .fill(level <= interestLevel ? Color.green : Color.gray.opacity(0.3))
                                        .frame(width: 20, height: 20)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.horizontal, 5)
                            }
                            
                            Spacer()
                            
                            Text("\(interestLevel)/3")
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.vertical, 5)
                    
                    // Simplified Referral Toggle
                    Toggle("Referral", isOn: $hasReferral)
                    
                    // Deadline Date (keep the same as it's functional)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Deadline")
                            Spacer()
                            Button(action: {
                                showDeadlinePicker.toggle()
                            }) {
                                if let date = deadlineDate {
                                    Text(date, style: .date)
                                } else {
                                    Text("Set Deadline")
                                }
                            }
                        }
                        
                        if showDeadlinePicker {
                            DatePicker(
                                "Select Deadline",
                                selection: Binding(
                                    get: { deadlineDate ?? Date() },
                                    set: { deadlineDate = $0 }
                                ),
                                displayedComponents: .date
                            )
                            .datePickerStyle(GraphicalDatePickerStyle())
                            
                            Button("Clear Deadline") {
                                deadlineDate = nil
                                showDeadlinePicker = false
                            }
                            .foregroundColor(.red)
                        }
                    }
                    
                    // Days in Status
                    Stepper("Days in Status: \(daysInStatus)", value: $daysInStatus, in: 0...365)
                }
                
                Section(header: Text("Status")) {
                    Picker("Status", selection: $status) {
                        ForEach(JobStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    // Progress indicator for current status
                    HStack(spacing: 8) {
                        ForEach(0..<7) { step in
                            Circle()
                                .fill(step <= statusStepIndex(status) ? Color.green : Color.gray.opacity(0.3))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.vertical, 8)
                    
                    // Additional info about resetting days when changing status
                    if job.status != status {
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                            Text("Changing status will reset days in status to 0")
                                .font(.caption)
                                .foregroundColor(.secondary)
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
    
    // Helper function to determine status step index (same as in other views)
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
    
    private func saveJob() {
        // Determine whether to reset days in status
        let newDaysInStatus = job.status != status ? 0 : daysInStatus
        
        // Create a new job instance with updated values
        let updatedJob = Job(
            id: job.id,
            jobTitle: jobTitle,
            orgName: orgName,
            jobLink: jobLink.isEmpty ? nil : URL(string: jobLink),
            contactName: contactName,
            interestLevel: interestLevel,
            hasReferral: hasReferral,
            deadlineDate: deadlineDate,
            status: status,
            notes: notes,
            date: job.date,
            description: description,
            daysInStatus: newDaysInStatus
        )
        
        jobStore.updateJob(updatedJob)
    }
}
