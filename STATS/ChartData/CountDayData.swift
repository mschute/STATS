import Foundation

// Data usable with Charts
//TODO: Create a set of data for week at a time
//TODO: Create a set of data for month at a time
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
