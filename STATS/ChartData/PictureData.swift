import Foundation

struct PictureData: Identifiable {
    var id: UUID
    var timestamp: Date
    var image: Data?
    
    init(id: UUID, timestamp: Date, image: Data) {
        self.id = id
        self.timestamp = timestamp
        self.image = image
    }
}
