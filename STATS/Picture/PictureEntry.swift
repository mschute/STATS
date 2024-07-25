import Foundation
import SwiftData

@Model
class PictureEntry: Entry, Identifiable {
    typealias T = PictureStat
    
    var pictureStat: PictureStat?
    var entryId: UUID
    var timestamp: Date
    var note: String
    
    @Attribute(.externalStorage) var image: Data?
    
    init(pictureStat: PictureStat, entryId: UUID, timestamp: Date, note: String, image: Data?) {
        self.pictureStat = pictureStat
        self.entryId = entryId
        self.timestamp = timestamp
        self.note = note
        self.image = image
    }
}
