//
//  Item.swift
//  job-tracker
//
//  Created by Langley Millard on 4/5/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
