import Foundation

// Data usable with Charts
struct CountDayData: Identifiable {
    var id: UUID
    var day: Date
    var count: Int
    
    init(day: Date, count: Int) {
        self.id = UUID()
        self.day = day
        self.count = count
    }
}
