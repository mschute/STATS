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
                        
                        //Truncate implementation: https://www.hackingwithswift.com/forums/swiftui/force-truncation-of-text-in-a-listview/13330
                        VStack(alignment: .leading, spacing: 8) {
                            Text(stat.name)
                                .font(.custom("Menlo", size: 16))
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Text("Decimal Stat")
                                .font(.custom("Menlo", size: 14))
                                .fontWeight(.regular)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 8) {
                        if let lastEntry = stat.statEntry.last {
                            let formattedValue = String(format: "%.2f", lastEntry.value)
                            Text("\(formattedValue) \(stat.unitName)")
                                .font(.custom("Menlo", size: 15))
                                .fontWeight(.semibold)
                            Text("\(lastEntry.timestamp, style: .date)")
                                .font(.custom("Menlo", size: 12))
                                .fontWeight(.regular)
                            
                        } else {
                            Text("No entries")
                                .fontWeight(.medium)
                        }
                    }
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
