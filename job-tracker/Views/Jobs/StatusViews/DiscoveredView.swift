import SwiftUI

struct DiscoveredView: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    @State private var selectedInterestLevel: Int
    @State private var hasReferral: Bool
    @State private var deadlineDate: Date
    @State private var showDatePicker = false
    
    // Initialize the state properties with job values
    init(job: Job, jobStore: JobStore) {
        self.job = job
        self.jobStore = jobStore
        _selectedInterestLevel = State(initialValue: job.interestLevel)
        _hasReferral = State(initialValue: job.hasReferral)
        _deadlineDate = State(initialValue: job.deadlineDate ?? Calendar.current.date(byAdding: .day, value: 14, to: Date())!)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("You haven't applied to this job yet.")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Job Details")
                    .font(.title3)
                    .bold()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Position: \(job.jobTitle)")
                    Text("Company: \(job.orgName)")
                    Text("Added on: \(job.date, formatter: dateFormatter)")
                    Text("Days in current status: \(job.daysInStatus)")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            // Interest level selector
            VStack(alignment: .leading, spacing: 8) {
                Text("Interest Level")
                    .font(.title3)
                    .bold()
                
                HStack {
                    ForEach(0..<4) { level in
                        Button(action: {
                            selectedInterestLevel = level
                        }) {
                            Image(systemName: level <= selectedInterestLevel ? "star.fill" : "star")
                                .foregroundColor(level <= selectedInterestLevel ? interestColor(for: selectedInterestLevel) : .gray)
                                .font(.system(size: 24))
                        }
                    }
                    Spacer()
                    Text(interestLevelText(selectedInterestLevel))
                        .foregroundColor(interestColor(for: selectedInterestLevel))
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            // Referral toggle
            VStack(alignment: .leading, spacing: 8) {
                Text("Do you have a referral?")
                    .font(.title3)
                    .bold()
                
                Toggle("I have a referral for this position", isOn: $hasReferral)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            
            // Application deadline
            VStack(alignment: .leading, spacing: 8) {
                Text("Application Deadline")
                    .font(.title3)
                    .bold()
                
                VStack {
                    Button(action: {
                        showDatePicker.toggle()
                    }) {
                        HStack {
                            Text("Deadline: \(deadlineDate, formatter: dateFormatter)")
                            Spacer()
                            Image(systemName: "calendar")
                        }
                    }
                    
                    if showDatePicker {
                        DatePicker("Select a deadline", selection: $deadlineDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding(.top)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            Spacer()
            
            HStack {
                // Save changes button
                Button("Save Changes") {
                    let updatedJob = job.updated(
                        interestLevel: selectedInterestLevel,
                        hasReferral: hasReferral
                    )
                    jobStore.updateJob(updatedJob)
                }
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity)
                
                // Mark as Applied button
                Button("Mark as Applied") {
                    let updatedJob = job.updated(
                        deadlineDate: deadlineDate,
                        status: .applied,
                        daysInStatus: 0 // Reset days in status when changing status
                    )
                    jobStore.updateJob(updatedJob)
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
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
