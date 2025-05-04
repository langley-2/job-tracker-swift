import SwiftUI

enum JobStatus: String, Codable, CaseIterable {
    case discovered = "Discovered"
    case researching = "Researching"
    case outreach = "Outreach"
    case applied = "Applied"
    case interviewing = "Interviewing"
    case offer = "Offer"
    case accepted = "Accepted"
    case rejected = "Rejected"
    case closed = "Closed"
    
    var systemImage: String {
        switch self {
        case .discovered: return "lightbulb"
        case .researching: return "magnifyingglass"
        case .outreach: return "envelope"
        case .applied: return "paperplane.fill"
        case .interviewing: return "person.fill"
        case .offer: return "checkmark.seal.fill"
        case .accepted: return "star.fill"
        case .rejected: return "xmark.circle.fill"
        case .closed: return "archivebox.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .discovered: return .gray
        case .researching: return .purple
        case .outreach: return .blue
        case .applied: return .indigo
        case .interviewing: return .orange
        case .offer: return .green
        case .accepted: return .mint
        case .rejected: return .red
        case .closed: return .secondary
        }
    }
}
