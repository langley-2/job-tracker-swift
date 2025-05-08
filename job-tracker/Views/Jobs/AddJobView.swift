import SwiftUI

struct AddJobView: View {
    @ObservedObject var jobStore: JobStore
    @Environment(\.dismiss) private var dismiss
    
    // Updated state properties to match new Job model
    @State private var jobTitle: String = ""
    @State private var orgName: String = ""
    @State private var jobLink: String = ""
    @State private var contactName: String = ""
    @State private var interestLevel: Int = 0 // Changed from isResearched
    @State private var hasReferral: Bool = false // Changed from hasReachedOut
    @State private var deadlineDate: Date? = nil // Changed from hasApplied
    @State private var showDeadlinePicker = false
    @State private var status: JobStatus = .discovered
    @State private var notes: String = ""
    @State private var description: String? = nil
    
    var body: some View {
        NavigationStack { // Using NavigationStack instead of NavigationView for better compatibility
            Form {
                Section(header: Text("Job Details")) {
                    TextField("Job Title", text: $jobTitle)
                    TextField("Organization Name", text: $orgName)
                    TextField("Job Link (URL)", text: $jobLink)
                    TextField("Contact Name", text: $contactName)
                    
                    // Description field
                    VStack(alignment: .leading) {
                        Text("Job Description (Optional)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: Binding(
                                get: { description ?? "" },
                                set: { description = $0.isEmpty ? nil : $0 }
                            ))
                            .frame(minHeight: 80)
                            
                            if description == nil || description?.isEmpty == true {
                                Text("Enter job description here")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 8)
                                    .allowsHitTesting(false)
                            }
                        }
                    }
                }
                
                Section(header: Text("Application Tracking")) {
                    // Interest Level
                    VStack(alignment: .leading) {
                        Text("Interest Level")
                        
                        HStack {
                            ForEach(0..<4) { level in
                                Button(action: {
                                    interestLevel = level
                                }) {
                                    Image(systemName: level <= interestLevel ? "star.fill" : "star")
                                        .foregroundColor(level <= interestLevel ? interestColor(for: interestLevel) : .gray)
                                        .font(.system(size: 24))
                                }
                            }
                            Spacer()
                            Text(interestLevelText(interestLevel))
                                .foregroundColor(interestColor(for: interestLevel))
                        }
                    }
                    
                    // Referral Toggle
                    Toggle("Have Referral", isOn: $hasReferral)
                    
                    // Deadline Date
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Application Deadline")
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
                }
                
                Section(header: Text("Status")) {
                    Picker("Status", selection: $status) {
                        ForEach(JobStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $notes)
                        .frame(minHeight: 100)
                }
            }
            .navigationTitle("Add New Job")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newJob = Job(
                            jobTitle: jobTitle,
                            orgName: orgName,
                            jobLink: jobLink.isEmpty ? nil : URL(string: jobLink),
                            contactName: contactName,
                            interestLevel: interestLevel,       // Changed from isResearched
                            hasReferral: hasReferral,           // Changed from hasReachedOut
                            deadlineDate: deadlineDate,         // Changed from hasApplied
                            status: status,
                            notes: notes,
                            description: description,
                            daysInStatus: 0                     // New jobs start with 0 days in status
                        )
                        
                        jobStore.addJob(newJob)
                        dismiss()
                    }
                    .disabled(jobTitle.isEmpty || orgName.isEmpty)
                }
            }
        }
    }
    
    // Helper function to get interest level text
    private func interestLevelText(_ level: Int) -> String {
        switch level {
        case 0: return "Not Interested"
        case 1: return "Slightly Interested"
        case 2: return "Interested"
        case 3: return "Very Interested"
        default: return "Unknown"
        }
    }
    
    // Helper function to get interest color
    private func interestColor(for level: Int) -> Color {
        switch level {
        case 0: return .gray
        case 1: return .blue
        case 2: return .orange
        case 3: return .green
        default: return .gray
        }
    }
}
