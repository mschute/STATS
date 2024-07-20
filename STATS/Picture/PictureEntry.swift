import Foundation
import SwiftData

@Model
class PictureEntry: Entry, Identifiable {
    typealias T = PictureStat
    
    @Relationship var pictureStat: PictureStat
    var entryId: UUID
    var timestamp: Date
    var note: String
    
    init(pictureStat: PictureStat, entryId: UUID, timestamp: Date, note: String) {
        self.pictureStat = pictureStat
        self.entryId = entryId
        self.timestamp = timestamp
        self.note = note
    }
}
