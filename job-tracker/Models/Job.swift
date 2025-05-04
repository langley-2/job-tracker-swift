import Foundation

struct Job: Identifiable, Codable {
    let id: UUID
    let jobTitle: String
    let orgName: String
    let jobLink: URL?
    let contactName: String
    let isResearched: Bool
    let hasReachedOut: Bool
    let hasApplied: Bool
    let status: JobStatus
    let notes: String
    let date: Date
    
    init(
        id: UUID = UUID(),
        jobTitle: String,
        orgName: String,
        jobLink: String? = nil,
        contactName: String = "",
        isResearched: Bool = false,
        hasReachedOut: Bool = false,
        hasApplied: Bool = false,
        status: JobStatus = .discovered,
        notes: String = "",
        date: Date = Date()
    ) {
        self.id = id
        self.jobTitle = jobTitle
        self.orgName = orgName
        self.jobLink = jobLink != nil ? URL(string: jobLink!) : nil
        self.contactName = contactName
        self.isResearched = isResearched
        self.hasReachedOut = hasReachedOut
        self.hasApplied = hasApplied
        self.status = status
        self.notes = notes
        self.date = date
    }
    
    // Add a function to create an updated copy
    func updated(
        jobTitle: String? = nil,
        orgName: String? = nil,
        jobLink: String? = nil,
        contactName: String? = nil,
        isResearched: Bool? = nil,
        hasReachedOut: Bool? = nil,
        hasApplied: Bool? = nil,
        status: JobStatus? = nil,
        notes: String? = nil
    ) -> Job {
        return Job(
            id: self.id,
            jobTitle: jobTitle ?? self.jobTitle,
            orgName: orgName ?? self.orgName,
            jobLink: jobLink ?? self.jobLink?.absoluteString,
            contactName: contactName ?? self.contactName,
            isResearched: isResearched ?? self.isResearched,
            hasReachedOut: hasReachedOut ?? self.hasReachedOut,
            hasApplied: hasApplied ?? self.hasApplied,
            status: status ?? self.status,
            notes: notes ?? self.notes,
            date: self.date
        )
    }
}
