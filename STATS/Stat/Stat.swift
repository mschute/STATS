import Foundation
import SwiftData
import SwiftUI

//https://developer.apple.com/tutorials/app-dev-training/using-existentials-and-generics
//Should these be changed to generics or does it have to be an existential type
protocol Stat {
    var name: String { get }
    var created: Date { get }
    var category: Category? { get }
    associatedtype EntryType: Entry
    var statEntry: [EntryType] { get }
    var persistentModelID: PersistentIdentifier { get }
    
// TODO: Should we add functions for the model
//    func Delete(modelContext: ModelContext);
//    
//    //https://developer.apple.com/documentation/swiftui/anyview
//    func detailView() -> AnyView
}
