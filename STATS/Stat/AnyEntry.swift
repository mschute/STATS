import Foundation

class AnyEntry: Identifiable {
    var entry: any Entry
    
    init(entry: any Entry) {
        self.entry = entry
    }
}
