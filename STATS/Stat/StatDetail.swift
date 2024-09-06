import SwiftUI

struct StatDetail: View {
    var stat: any Stat
    
    var body: some View {
        VStack(spacing: 0) {
            TopBar(title: "\(stat.name)", topPadding: 20, bottomPadding: 40)
                .dismissKeyboard()
            StatDetailTabs(stat: stat as any Stat)
        }
    }
}
