import SwiftUI

struct JobRowView: View {
    let job: Job
    
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
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(job.jobTitle)
                    .font(.headline)
                Text(job.orgName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                HStack {
                    Image(systemName: job.status.systemImage)
                        .foregroundColor(job.status.color)
                    Text(job.status.rawValue)
                        .font(.subheadline)
                        .foregroundColor(job.status.color)
                }
                
                // Progress indicator based on current status
                HStack(spacing: 8) {
                    ForEach(0..<7) { step in
                        let currentStepIndex = statusStepIndex(job.status)
                        Circle()
                            .fill(step <= currentStepIndex ? Color.green : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}
