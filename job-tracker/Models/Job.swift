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
    let description: String?  // Added optional description field

    init(
        id: UUID = UUID(),
        jobTitle: String,
        orgName: String,
        jobLink: URL? = nil,
        contactName: String = "",
        isResearched: Bool = false,
        hasReachedOut: Bool = false,
        hasApplied: Bool = false,
        status: JobStatus = .discovered,
        notes: String = "",
        date: Date = Date(),
        description: String? = nil  // Added parameter with default value of nil
    ) {
        self.id = id
        self.jobTitle = jobTitle
        self.orgName = orgName
        self.jobLink = jobLink
        self.contactName = contactName
        self.isResearched = isResearched
        self.hasReachedOut = hasReachedOut
        self.hasApplied = hasApplied
        self.status = status
        self.notes = notes
        self.date = date
        self.description = description  // Initialize the new property
    }

    func updated(
        jobTitle: String? = nil,
        orgName: String? = nil,
        jobLink: URL? = nil,
        contactName: String? = nil,
        isResearched: Bool? = nil,
        hasReachedOut: Bool? = nil,
        hasApplied: Bool? = nil,
        status: JobStatus? = nil,
        notes: String? = nil,
        description: String? = nil  // Added parameter to updated method
    ) -> Job {
        return Job(
            id: self.id,
            jobTitle: jobTitle ?? self.jobTitle,
            orgName: orgName ?? self.orgName,
            jobLink: jobLink ?? self.jobLink,
            contactName: contactName ?? self.contactName,
            isResearched: isResearched ?? self.isResearched,
            hasReachedOut: hasReachedOut ?? self.hasReachedOut,
            hasApplied: hasApplied ?? self.hasApplied,
            status: status ?? self.status,
            notes: notes ?? self.notes,
            date: self.date,
            description: description ?? self.description  // Use existing description if not provided
        )
    }
}
