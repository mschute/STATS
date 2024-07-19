import SwiftUI

struct PictureDetail: View {
    var stat: PictureStat
    
    var body: some View {
        Text("\(stat.name) Picture Stat Detail")
            .font(.largeTitle)
        StatDetailTabs(stat: stat as any Stat)
        Spacer()
    }
}
//
//#Preview {
//    PictureDetail()
//}
