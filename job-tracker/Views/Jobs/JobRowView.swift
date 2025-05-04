import SwiftUI

struct JobRowView: View {
    let job: Job
    
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
                
                // Progress indicators for research, outreach, application
                HStack(spacing: 3) {
                    Circle()
                        .fill(job.isResearched ? Color.green : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                    
                    Circle()
                        .fill(job.hasReachedOut ? Color.green : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                    
                    Circle()
                        .fill(job.hasApplied ? Color.green : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
