import SwiftUI

struct StatusSpecificView: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    @State private var showingStatusUpdate = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Current Status: \(job.status.rawValue)")
                    .font(.headline)
                
                Spacer()
                
                Button("Update") {
                    showingStatusUpdate = true
                }
                .buttonStyle(.bordered)
            }
            
            statusContent
            
            Spacer()
            
            Button("Update Status") {
                showingStatusUpdate = true
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .actionSheet(isPresented: $showingStatusUpdate) {
                statusActionSheet()
            }
        }
    }
    
    @ViewBuilder
    var statusContent: some View {
        switch job.status {
        case .discovered:
            DiscoveredStatusView()
        case .researching:
            ResearchingStatusView()
        case .outreach:
            OutreachStatusView()
        case .applied:
            AppliedStatusView()
        case .interviewing:
            InterviewingStatusView()
        case .offer:
            OfferStatusView()
        case .accepted:
            AcceptedStatusView()
        case .rejected:
            RejectedStatusView()
        case .closed:
            ClosedStatusView()
        }
    }
    
    private func statusActionSheet() -> ActionSheet {
        var buttons: [ActionSheet.Button] = []
        
        // Add appropriate next status options based on current status
        switch job.status {
        case .discovered:
            buttons.append(.default(Text("Researching")) { updateStatus(.researching) })
            buttons.append(.default(Text("Outreach")) { updateStatus(.outreach) })
            
        case .researching:
            buttons.append(.default(Text("Outreach")) { updateStatus(.outreach) })
            buttons.append(.default(Text("Applied")) { updateStatus(.applied) })
            
        case .outreach:
            buttons.append(.default(Text("Applied")) { updateStatus(.applied) })
            
        case .applied:
            buttons.append(.default(Text("Interviewing")) { updateStatus(.interviewing) })
            buttons.append(.destructive(Text("Rejected")) { updateStatus(.rejected) })
            
        case .interviewing:
            buttons.append(.default(Text("Offer")) { updateStatus(.offer) })
            buttons.append(.destructive(Text("Rejected")) { updateStatus(.rejected) })
            
        case .offer:
            buttons.append(.default(Text("Accepted")) { updateStatus(.accepted) })
            buttons.append(.destructive(Text("Rejected")) { updateStatus(.rejected) })
            
        case .accepted, .rejected:
            buttons.append(.default(Text("Close")) { updateStatus(.closed) })
            
        case .closed:
            break  // No further actions for closed jobs
        }
        
        // Always add a cancel button
        buttons.append(.cancel())
        
        return ActionSheet(
            title: Text("Update Job Status"),
            message: Text("Select the new status for this job"),
            buttons: buttons
        )
    }
    
    private func updateStatus(_ newStatus: JobStatus) {
        // Create a new job instance with the updated status
        let updatedJob = job.updated(status: newStatus)
        jobStore.updateJob(updatedJob)
    }
}

// Status-specific content views
struct DiscoveredStatusView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("You've discovered this job opportunity. Start by researching the company and position.")
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
    }
}

// Other status-specific views remain the same
struct ResearchingStatusView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Research Tips:")
                .font(.subheadline)
                .bold()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("• Company culture and values")
                Text("• Job responsibilities and requirements")
                Text("• Industry trends and challenges")
                Text("• Salary range expectations")
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

struct OutreachStatusView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Outreach Tips:")
                .font(.subheadline)
                .bold()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("• Connect with employees on LinkedIn")
                Text("• Request informational interviews")
                Text("• Attend company events or webinars")
                Text("• Engage with company social media")
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

struct AppliedStatusView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Application submitted. Now is a good time to:")
                .font(.subheadline)
                .bold()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("• Follow up within 1-2 weeks if no response")
                Text("• Prepare for potential interviews")
                Text("• Continue applying to other positions")
                Text("• Track application materials for reference")
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

struct InterviewingStatusView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Interview Preparation:")
                .font(.subheadline)
                .bold()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("• Research common interview questions")
                Text("• Prepare STAR method answers")
                Text("• Research your interviewers")
                Text("• Practice salary negotiation")
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

struct OfferStatusView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Offer Consideration:")
                .font(.subheadline)
                .bold()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("• Analyze compensation package")
                Text("• Consider growth opportunities")
                Text("• Evaluate work-life balance")
                Text("• Compare with other offers or current job")
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

struct AcceptedStatusView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Congratulations! Next steps:")
                .font(.subheadline)
                .bold()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("• Complete any onboarding paperwork")
                Text("• Gracefully exit current role")
                Text("• Prepare for your first day")
                Text("• Connect with new colleagues")
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

struct RejectedStatusView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("It's okay! Every application is a learning experience.")
                .font(.subheadline)
                .bold()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("• Request feedback if possible")
                Text("• Review what you can improve")
                Text("• Focus on other opportunities")
                Text("• Consider upskilling if necessary")
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

struct ClosedStatusView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("This application has been closed.")
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
    }
}
