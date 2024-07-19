import SwiftUI

struct PictureEntryCard: View {
    var pictureEntry: PictureEntry
    
    //TODO: Need to add picture specific things in here
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
