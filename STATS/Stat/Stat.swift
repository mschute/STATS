import Foundation
import SwiftData
import SwiftUI

protocol Stat {
    var name: String { get }
    var created: Date { get }
    associatedtype EntryType: Entry
    var statEntry: [EntryType] { get }
    var persistentModelID: PersistentIdentifier { get }
    
// TODO: Should we add functions for the model
//    func Delete(modelContext: ModelContext);
//    
//    //https://developer.apple.com/documentation/swiftui/anyview
//    func detailView() -> AnyView
}
