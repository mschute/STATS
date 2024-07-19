import Foundation

protocol Entry {
    associatedtype T
    var entryId: UUID { get }
    var timestamp: Date { get }
}
