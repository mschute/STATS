import Foundation

protocol Entry {
    var timestamp: Date { get }
    var note: String { get }
    associatedtype StatType: Stat
    var stat: StatType? { get }
}
