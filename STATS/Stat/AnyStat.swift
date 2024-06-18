//
//  File.swift
//  STATS
//
//  Created by Staff on 14/06/2024.
//

import Foundation

class StatWrapper: Identifiable {
    var stat: StatisticType
    
    init(stat: StatisticType) {
        self.stat = stat
    }
}
