import SwiftUI

struct PictureCard: View {
    var stat: PictureStat
    
    var body: some View {
        NavigationLink {
            PictureDetail(stat: stat)
        } label: {
            Text("\(stat.name) Detail")
        }
    }
}

//#Preview {
//    PictureCard()
//}
