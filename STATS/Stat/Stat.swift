import Foundation
import SwiftData

protocol Stat {
    var name: String { get }
    var created: Date { get }
    var desc: String { get }
    var icon: String { get }
    var category: Category? { get }
    //Protocol rule, any type conforming to Stat must specify a concrete type for EntryType which conforms to Entry protocol
    associatedtype EntryType: Entry
    var statEntry: [EntryType] { get }
    var persistentModelID: PersistentIdentifier { get }
}
