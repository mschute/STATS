//
//  Entry.swift
//  STATS
//
//  Created by Staff on 16/06/2024.
//

import Foundation

protocol Entry {
    associatedtype T
    var entryId: UUID { get }
    var value: T { get }
    var timestamp: Date { get }
}
