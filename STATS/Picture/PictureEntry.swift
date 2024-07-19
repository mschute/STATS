import Foundation
import SwiftData

@Model
class PictureEntry: Entry, Identifiable {
    typealias T = PictureStat
    
    // Database migration failing, need to set to optional even though this is technically required.
    // Unsure why this needs to be optional but the one in the Decimal doesnt?
    // This may cause an error in production
    //https://stackoverflow.com/questions/46092508/code-134110-validation-error-missing-attribute-values-on-mandatory-destination
    
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
