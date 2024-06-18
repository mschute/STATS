import Foundation
import SwiftData
import SwiftUI

protocol Stat {
    var name: String { get }
    var created: Date { get }
    
    func Delete(modelContext: ModelContext);
    
    //https://developer.apple.com/documentation/swiftui/anyview
    func detailView() -> AnyView
}
