import Foundation
import SwiftData

@Model
class PictureEntry: Entry, Identifiable {
    var entryId: UUID
    var timestamp: Date
    var note: String
    //Associated relationship must be optional / does not need @Relationship
    var stat: PictureStat?
    @Attribute(.externalStorage) var image: Data?
    
    init(entryId: UUID = UUID(), timestamp: Date = Date(), note: String = "", image: Data? = nil) {
        self.entryId = entryId
        self.timestamp = timestamp
        self.note = note
        self.image = image
    }
}
