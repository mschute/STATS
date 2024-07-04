import Foundation

protocol Entry {
    associatedtype T
    var entryId: UUID { get }
    var value: T { get }
    var timestamp: Date { get }
}
