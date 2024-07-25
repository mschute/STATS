import SwiftUI

struct PictureEntryCard: View {
    var pictureEntry: PictureEntry
    
    var body: some View {
        NavigationLink {
            PictureEntryFormEdit(pictureEntry: pictureEntry)
        } label: {
            VStack {
                Text("Timestamp: \(pictureEntry.timestamp)")
                
                if let selectedPhotoData = pictureEntry.image,
                   let uiImage = UIImage(data: selectedPhotoData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
            .frame(alignment: .leading)
        }
    }
}

//#Preview {
//    PictureEntryCard()
//}
