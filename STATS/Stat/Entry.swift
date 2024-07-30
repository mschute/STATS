import Foundation

protocol Entry {
    var entryId: UUID { get }
    var timestamp: Date { get }
    var note: String { get }
}
