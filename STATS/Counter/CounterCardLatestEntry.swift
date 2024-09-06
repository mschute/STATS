import SwiftUI

struct CounterCardLatestEntry: View {
    var stat: CounterStat
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            if (stat.statEntry.isEmpty) {
                Text("No entries")
                    .font(.custom("Menlo", size: 13))
                    .fontWeight(.semibold)
                
            } else {
                Text("Latest Entry:")
                    .font(.custom("Menlo", size: 13))
                    .fontWeight(.semibold)
                
                if let latestEntry = stat.statEntry
                    .sorted(by: { $0.timestamp > $1.timestamp })
                    .first {
                    Text("\(DateUtility.abbreviatedDateString(date: latestEntry.timestamp))")
                            .font(.custom("Menlo", size: 12))
                            .fontWeight(.regular)
                    }
            }
        }
        .frame(maxWidth: 105)
    }
}
