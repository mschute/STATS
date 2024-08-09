import SwiftUI

struct CounterCard: View {
    var stat: CounterStat
    
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
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Text("Counter Stat")
                                .font(.custom("Menlo", size: 14))
                                .fontWeight(.regular)
                        }
                    }
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 8) {
                        Text("Last Entry:")
                            .font(.custom("Menlo", size: 14))
                            .fontWeight(.medium)
                        if let lastEntry = stat.statEntry.last {
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
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .gradientFilter(gradientColor: .counter, gradientHighlight: .counterHighlight, cornerRadius: 12)
            NavigationLink(destination: CounterDetail(stat: stat)) {
                EmptyView()
            }
            .opacity(0.0)
            .navigationTitle("")
        }
    }
}
