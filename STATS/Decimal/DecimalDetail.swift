import SwiftUI

struct DecimalDetail: View {
    var stat: DecimalStat
    
    var body: some View {
        Text("\(stat.name) Decimal Stat Detail")
            .font(.largeTitle)
        
        StatDetailTabs(stat: stat as any Stat)
        Spacer()
    }
}
