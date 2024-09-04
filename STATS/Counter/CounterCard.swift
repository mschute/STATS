import SwiftUI

struct CounterCard: View {
    var stat: CounterStat
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    HStack(alignment: .top, spacing: 15) {
                        Image(systemName: stat.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(stat.name)
                                .font(.custom("Menlo", size: 16))
                                .fontWeight(.bold)
                            Text("Counter Stat")
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
            .padding()
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .gradientFilter(gradientColor: .cyan, gradientHighlight: .counterHighlight, cornerRadius: 12)
            
            NavigationLink(destination: CounterDetail(stat: stat)) {
                EmptyView()
            }
            .opacity(0.0)
            .navigationTitle("")
        }
    }
}
