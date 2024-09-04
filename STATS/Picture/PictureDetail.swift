import SwiftUI

struct PictureDetail: View {
    var stat: PictureStat
    
    var body: some View {
        VStack(spacing: 0) {
            TopBar(title: "\(stat.name)", topPadding: 20, bottomPadding: 40)
                .dismissKeyboard()
            StatDetailTabs(stat: stat as any Stat)
        }
    }
}
