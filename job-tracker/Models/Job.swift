import Foundation

struct Job: Identifiable, Codable {
    let id: UUID
    let jobTitle: String
    let orgName: String
    let jobLink: URL?
    let contactName: String
    let interestLevel: Int  // Changed from isResearched (Bool) to interestLevel (Int 0-3)
    let hasReferral: Bool   // Changed from hasReachedOut to hasReferral
    let deadlineDate: Date? // Changed from hasApplied (Bool) to deadlineDate (optional Date)
    let status: JobStatus
    let notes: String
    let date: Date
    let description: String?
    let daysInStatus: Int   // Added new parameter for tracking days in current status

    init(
        id: UUID = UUID(),
        jobTitle: String,
        orgName: String,
        jobLink: URL? = nil,
        contactName: String = "",
        interestLevel: Int = 0,         // Changed from isResearched with default 0
        hasReferral: Bool = false,      // Changed from hasReachedOut
        deadlineDate: Date? = nil,      // Changed from hasApplied to optional Date
        status: JobStatus = .discovered,
        notes: String = "",
        date: Date = Date(),
        description: String? = nil,
        daysInStatus: Int = 0           // Added with default value of 0
    ) {
        self.id = id
        self.jobTitle = jobTitle
        self.orgName = orgName
        self.jobLink = jobLink
        self.contactName = contactName
        self.interestLevel = min(max(interestLevel, 0), 3)  // Ensure interest level is between 0-3
        self.hasReferral = hasReferral
        self.deadlineDate = deadlineDate
        self.status = status
        self.notes = notes
        self.date = date
        self.description = description
        self.daysInStatus = daysInStatus
    }

    func updated(
        jobTitle: String? = nil,
        orgName: String? = nil,
        jobLink: URL? = nil,
        contactName: String? = nil,
        interestLevel: Int? = nil,       // Changed from isResearched
        hasReferral: Bool? = nil,        // Changed from hasReachedOut
        deadlineDate: Date? = nil,       // Changed from hasApplied
        status: JobStatus? = nil,
        notes: String? = nil,
        description: String? = nil,
        daysInStatus: Int? = nil         // Added parameter
    ) -> Job {
        return Job(
            id: self.id,
            jobTitle: jobTitle ?? self.jobTitle,
            orgName: orgName ?? self.orgName,
            jobLink: jobLink ?? self.jobLink,
            contactName: contactName ?? self.contactName,
            interestLevel: interestLevel ?? self.interestLevel,
            hasReferral: hasReferral ?? self.hasReferral,
            deadlineDate: deadlineDate ?? self.deadlineDate,
            status: status ?? self.status,
            notes: notes ?? self.notes,
            date: self.date,
            description: description ?? self.description,
            daysInStatus: daysInStatus ?? self.daysInStatus
        )
    }
}
