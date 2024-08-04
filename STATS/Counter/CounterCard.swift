import SwiftUI

struct CounterCard: View {
    var stat: CounterStat
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    HStack(spacing: 15) {
                        Image(systemName: stat.icon != "network" ? stat.icon : "goforward.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                        VStack(alignment: .leading) {
                            Text(stat.name)
                                .font(.custom("Menlo", size: 15))
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Text("Counter Stat")
                                .fontWeight(.regular)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Last Entry:")
                            .fontWeight(.medium)
                        if let lastEntry = stat.statEntry.last {
                            Text("\(lastEntry.timestamp, style: .date)")
                                .font(.custom("Menlo", size: 10))
                                .fontWeight(.regular)
                        } else {
                            Text("No entries")
                                .fontWeight(.medium)
                        }
                    }
                }
            }
            .padding()
            .environment(\.font, .custom("Menlo", size: 14))
            .background(Color.counter)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            
            NavigationLink(destination: CounterDetail(stat: stat)) {
                EmptyView()
            }
            .opacity(0.0)
        }
    }
}
