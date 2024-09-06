import Foundation
import SwiftData
import SwiftUI

protocol Stat {
    var name: String { get }
    var created: Date { get }
    var desc: String { get }
    var icon: String { get }
    var reminder: Reminder? { get }
    var category: Category? { get }
    var modelName: String { get }
    var statColor: Color { get }
    var gradientHighlight: Color { get }
    //Protocol rule, any type conforming to Stat must specify a concrete type for EntryType which conforms to Entry protocol
    associatedtype EntryType: Entry
    var statEntry: [EntryType] { get }
    var persistentModelID: PersistentIdentifier { get }
}
