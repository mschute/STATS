import SwiftUI

struct PictureDetail: View {
    var stat: PictureStat
    
    var body: some View {
        VStack(spacing: 0) {
            TopBar(title: "\(stat.name)", topPadding: 0, bottomPadding: 20)
            StatDetailTabs(stat: stat as any Stat)
        }
    }
}
