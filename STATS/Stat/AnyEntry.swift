//
//  AnyEntry.swift
//  STATS
//
//  Created by Staff on 30/06/2024.
//

import Foundation

class AnyEntry: Identifiable {
    var entry: any Entry
    
    init(entry: any Entry) {
        self.entry = entry
    }
}
