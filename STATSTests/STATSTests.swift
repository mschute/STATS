import XCTest
import SwiftData
import Foundation
@testable import STATS

//Basics of unit testing: https://www.youtube.com/watch?v=opkU2UuPk0A
// SwiftData unit testing: https://www.youtube.com/watch?v=OF7TLbMu1ZQ
final class STATSTests: XCTestCase {

    private var context: ModelContext!
    
    @MainActor
    override func setUp() {
        print("setUp()")
        context = mockContainer.mainContext
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    @MainActor
    override func tearDown()  {
        print("tearDown()")
        do {
            try context.delete(model: CounterStat.self)
        } catch {
            print("failed to tear down counterSTat")
        }
        try! context.delete(model: Category.self)
        try! context.delete(model: Reminder.self)
        
        try! context.delete(model: CounterEntry.self)
        
    }

    func testAddCounter() throws {
        print("testAddCounter()")
        //Arrange
        let category = Category(name: "Health")
        let fetchRequest = FetchDescriptor<CounterStat>(
            predicate: #Predicate {
                counter in counter.name == "Water"
            }
        )
        
        //Act
        CounterStat.addCounter(hasReminder: true, interval: "1", reminders: [], name: "Water", created: Date(), desc: "Drink water everyday", icon: "goforward", chosenCategory: category, modelContext: context)

        let fetchedResult = try context.fetch(fetchRequest)
        
        //Assert
        XCTAssertEqual(fetchedResult.count, 1)
        
        if let retrievedCounter = fetchedResult.first {
            XCTAssertEqual(retrievedCounter.name, "Water")
            XCTAssertEqual(retrievedCounter.desc, "Drink water everyday")
            XCTAssertEqual(retrievedCounter.icon, "goforward")
            XCTAssertEqual(retrievedCounter.reminder?.interval, 1)
            XCTAssertEqual(retrievedCounter.reminder?.reminderTime, [])
            XCTAssertEqual(retrievedCounter.category?.name, "Health")
        }
    }
    
    func testCategoryAlreadyExists() {
        //Arrange
        var alertMessage = ""
        var showAlert = false
        let category = Category(name: "TestCategory")
        context.insert(category)
        
        //Act
        let result = Category.validateCategory(category: category.name, alertMessage: &alertMessage, showAlert: &showAlert, modelContext: context)
        
        //Assert
        XCTAssertFalse(result)
        XCTAssertEqual(alertMessage, "This tag already exists")
        XCTAssertTrue(showAlert)
    }
    
    func testGetEntryDateRange() throws {
        print("testGetEntryDateRange()")
        //Arrange
        var dateComponents1 = DateComponents()
        dateComponents1.year = 2024
        dateComponents1.month = 8
        dateComponents1.day = 11
        dateComponents1.timeZone =  TimeZone(abbreviation: "BST")
        dateComponents1.hour = 16
        dateComponents1.minute = 32
        
        let calendar1 = Calendar(identifier: .gregorian)
        let someDateTime1 = calendar1.date(from: dateComponents1)
        
        let counterEntry1 = CounterEntry(timestamp: someDateTime1 ?? Date(), note: "Test note")
        
        var dateComponents2 = DateComponents()
        dateComponents2.year = 2024
        dateComponents2.month = 8
        dateComponents2.day = 01
        dateComponents2.timeZone =  TimeZone(abbreviation: "BST")
        dateComponents2.hour = 10
        dateComponents2.minute = 54
        
        let calendar2 = Calendar(identifier: .gregorian)
        let someDateTime2 = calendar2.date(from: dateComponents2)
        
        let counterEntry2 = CounterEntry(timestamp: someDateTime2 ?? Date(), note: "Test note")
        
        var counterEntryArray: [any Entry] = []
        counterEntryArray.append(counterEntry1)
        counterEntryArray.append(counterEntry2)
        
        //Act
        var dateRange = AnyEntry.getEntryDateRange(entryArray: counterEntryArray)
        
        let expectedStartDate = DateUtility.startOfDay(date: someDateTime2 ?? Date())
        let expectedEndDate = DateUtility.endOfDay(date: someDateTime1 ?? Date())
        
        //Assert
        XCTAssertEqual(dateRange.startDate, expectedStartDate)
        XCTAssertEqual(dateRange.endDate, expectedEndDate)
    }
}
