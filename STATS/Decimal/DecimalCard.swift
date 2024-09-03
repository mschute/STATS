import SwiftUI

struct DecimalCard: View {
    var stat: DecimalStat
    
    //Remove navigation chevron: https://www.devtechie.com/community/public/posts/225203-how-to-hide-disclosure-indicator-from-navigationlink-in-swiftuii
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    HStack(spacing: 15) {
                        Image(systemName: stat.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(stat.name)
                                .font(.custom("Menlo", size: 16))
                                .fontWeight(.bold)
                            Text("Decimal Stat")
                                .font(.custom("Menlo", size: 13))
                                .fontWeight(.regular)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 8) {
                        if (stat.statEntry.isEmpty) {
                            Text("No entries")
                                .font(.custom("Menlo", size: 13))
                                .fontWeight(.medium)
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
            .font(.custom("Menlo", size: 13))
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .gradientFilter(gradientColor: .decimal, gradientHighlight: .decimalHighlight, cornerRadius: 12)
            
            NavigationLink(destination: DecimalDetail(stat: stat)) {
                EmptyView()
            }
            .opacity(0.0)
            .navigationTitle("")
        }
    }
}
