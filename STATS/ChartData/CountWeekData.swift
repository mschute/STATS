import Foundation

struct CountWeekData: Identifiable {
    var id: UUID
    var weekStart: Date
    var weekEnd: Date
    var count: Int
    
    init(weekStart: Date, weekEnd: Date, count: Int) {
        self.id = UUID()
        self.weekStart = weekStart
        self.weekEnd = weekEnd
        self.count = count
    }
}
