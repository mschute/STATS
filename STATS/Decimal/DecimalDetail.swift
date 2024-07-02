import SwiftUI

struct DecimalDetail: View {
    var stat: DecimalStat
    
    var body: some View {
        Text("\(stat.name)")
            .font(.largeTitle)
        
        StatDetailTabs(stat: stat as any Stat)
    }
}
