import SwiftUI

struct DecimalCardLatestEntry: View {
    var stat: DecimalStat
    
    //Remove navigation chevron: https://www.devtechie.com/community/public/posts/225203-how-to-hide-disclosure-indicator-from-navigationlink-in-swiftuii
    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            if (stat.statEntry.isEmpty) {
                Text("No entries")
                    .font(.custom("Menlo", size: 13))
                    .fontWeight(.semibold)
            } else {
                if let latestEntry = stat.statEntry
                    .sorted(by: { $0.timestamp > $1.timestamp })
                    .first {
                    let formattedValue = String(format: "%.2f", latestEntry.value)
                    Text("\(formattedValue) \(stat.unitName)")
                        .font(.custom("Menlo", size: 15))
                        .fontWeight(.semibold)
                    Text("\(DateUtility.abbreviatedDateString(date: latestEntry.timestamp))")
                        .font(.custom("Menlo", size: 12))
                        .fontWeight(.regular)
                }
            }
        }
        .frame(maxWidth: 105)
    }
}
