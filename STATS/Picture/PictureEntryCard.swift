import SwiftUI

struct PictureEntryCard: View {
    var pictureEntry: PictureEntry
    
    var body: some View {
        NavigationLink {
            PictureEntryFormEdit(pictureEntry: pictureEntry)
        } label: {
            VStack {
                Text("Timestamp: \(pictureEntry.timestamp)")
            }
            .frame(alignment: .leading)
        }
    }
}

//#Preview {
//    PictureEntryCard()
//}
