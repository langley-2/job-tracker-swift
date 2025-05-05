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
                isResearched: true,
                hasReachedOut: true,
                hasApplied: true,
                status: .applied,
                notes: "Applied through company website"
            ),
            Job(
                jobTitle: "Software Engineer",
                orgName: "Google",
                hasReachedOut: true,
                hasApplied: false,
                status: .interviewing,
                notes: "First interview scheduled for next week"
            ),
            Job(
                jobTitle: "UI Designer",
                orgName: "Microsoft",
                isResearched: true,
                hasReachedOut: false,
                hasApplied: false,
                status: .discovered,
                notes: "Job looks interesting, need to reach out"
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
