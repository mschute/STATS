import SwiftUI

struct StatCard: View {
    var stat: AnyStat
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    HStack(alignment: .top, spacing: 15) {
                        Image(systemName: stat.stat.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(stat.stat.name)
                                .font(.custom("Menlo", size: 16))
                                .fontWeight(.bold)
                            Text(stat.stat.modelName)
                                .font(.custom("Menlo", size: 13))
                                .fontWeight(.regular)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    AnyStat.CardLatestEntryContent(stat: stat.stat)
                }
            }
            .padding()
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .gradientFilter(gradientColor: stat.stat.statColor, gradientHighlight: stat.stat.gradientHighlight, cornerRadius: 12)
            
            NavigationLink(destination: AnyStat.StatDetail(stat: stat.stat)) {
                EmptyView()
            }
            .opacity(0.0)
            .navigationTitle("")
        }
    }
}
