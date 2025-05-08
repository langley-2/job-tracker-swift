import Foundation
import Combine

class JobStore: ObservableObject {
    @Published var jobs: [Job] = []
    
    init() {
        loadJobs()
    }
    
    func loadJobs() {
        // In a real app, load from UserDefaults, CoreData, or SwiftData
        // For now, just use sample data
        jobs = [
            Job(
                jobTitle: "iOS Developer",
                orgName: "Apple",
                jobLink: URL(string: "https://apple.com/careers"),
                contactName: "Tim Cook",
                interestLevel: 3,                                    // Changed from isResearched: true
                hasReferral: true,                                   // Changed from hasReachedOut: true
                deadlineDate: Calendar.current.date(byAdding: .day, value: 14, to: Date()), // Instead of hasApplied: true
                status: .applied,
                notes: "Applied through company website",
                daysInStatus: 3                                      // Added new parameter
            ),
            Job(
                jobTitle: "Software Engineer",
                orgName: "Google",
                jobLink: nil,
                contactName: "",
                interestLevel: 2,                                    // Default value since isResearched wasn't specified
                hasReferral: true,                                   // Changed from hasReachedOut: true
                deadlineDate: nil,                                   // Changed from hasApplied: false
                status: .interviewing,
                notes: "First interview scheduled for next week",
                daysInStatus: 5                                      // Added new parameter
            ),
            Job(
                jobTitle: "UI Designer",
                orgName: "Microsoft",
                jobLink: nil,
                contactName: "",
                interestLevel: 3,                                    // Changed from isResearched: true
                hasReferral: false,                                  // Changed from hasReachedOut: false
                deadlineDate: nil,                                   // Changed from hasApplied: false
                status: .discovered,
                notes: "Job looks interesting, need to reach out",
                daysInStatus: 1                                      // Added new parameter
            ),
            // Added a new sample job with more diverse parameters
            Job(
                jobTitle: "Product Manager",
                orgName: "Amazon",
                jobLink: URL(string: "https://amazon.com/jobs"),
                contactName: "Jeff Bezos",
                interestLevel: 1,                                    // Low interest
                hasReferral: true,                                   // Has a referral
                deadlineDate: Calendar.current.date(byAdding: .day, value: -2, to: Date()), // Past deadline
                status: .offer,
                notes: "Received offer, negotiating compensation",
                description: "Role involves managing e-commerce product teams",
                daysInStatus: 7                                      // Been in offer status for a week
            )
        ]
    }
    
    func addJob(_ job: Job) {
        jobs.append(job)
        saveJobs()
    }
    
    func updateJob(_ job: Job) {
        if let index = jobs.firstIndex(where: { $0.id == job.id }) {
            jobs[index] = job
            saveJobs()
        }
    }
    
    func deleteJob(_ job: Job) {
        jobs.removeAll { $0.id == job.id }
        saveJobs()
    }
    
    private func saveJobs() {
        // In a real app, save to UserDefaults, CoreData, or SwiftData
    }
}
