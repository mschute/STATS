import Foundation
import SwiftData
import SwiftUI

@Model
final class PictureEntry: Entry, Identifiable {
    var timestamp: Date
    var note: String
    //Associated relationship must be optional / does not need @Relationship
    var stat: PictureStat?
    @Attribute(.externalStorage) var image: Data?
    
    init(timestamp: Date = Date(), note: String = "", image: Data? = nil) {
        self.timestamp = timestamp
        self.note = note
        self.image = image
    }
}

extension PictureEntry {
    static func addEntry(pictureStat: PictureStat, timestamp: Date, note: String, image: Data?, modelContext: ModelContext) {
        let newEntry = PictureEntry(
            timestamp: timestamp,
            note: note,
            image: image
        )
        
        pictureStat.statEntry.append(newEntry)
        
        //Save() not necessary but included it for clarity in the purpose of the method
        do {
            try modelContext.save()
        } catch {
            print("Error adding entry")
        }
    }
    
    static func saveEntry(pictureEntry: PictureEntry, timestamp: Date, note: String, selectedPhotoData: Data?, modelContext: ModelContext) {
        pictureEntry.timestamp = timestamp
        pictureEntry.note = note
        pictureEntry.image = selectedPhotoData
        
        //Save() not necessary but included it for clarity in the purpose of the method
        do {
            try modelContext.save()
        } catch {
            print("Error saving entry")
        }
    }
    
    static func deleteItems(offsets: IndexSet, entries: [PictureEntry], modelContext: ModelContext) {
        withAnimation {
            // Uses IndexSet to remove from [AnyStat] and ModelContext
            // Used IndexSet rather than Index for future scalability
            for index in offsets {
                modelContext.delete(entries[index])
            }
        }
    }
    
    static func predicate(id: PersistentIdentifier, startDate: Date, endDate: Date) -> Predicate<PictureEntry> {
        return #Predicate<PictureEntry> {
            entry in entry.stat?.persistentModelID == id && (entry.timestamp >= startDate && entry.timestamp <= endDate)
        }
    }
}
