import Foundation
import SwiftData
import SwiftUI

//https://developer.apple.com/tutorials/app-dev-training/using-existentials-and-generics
protocol Stat {
    var name: String { get }
    var created: Date { get }
    var category: Category? { get }
    associatedtype EntryType: Entry
    var statEntry: [EntryType] { get }
    var persistentModelID: PersistentIdentifier { get }
}
