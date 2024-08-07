import SwiftUI

struct CounterEntryCard: View {
    @Environment (\.colorScheme) var colorScheme
    var counterEntry: CounterEntry
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "\(counterEntry.stat?.icon ?? "network")")
                        .fontWeight(.bold)
                    Text("\(counterEntry.stat?.name ?? "") Entry")
                        .font(.custom("Menlo", size: 16))
                        .fontWeight(.bold)
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1), radius: 3, x: 3, y: 2)
                        .lineLimit(1)
                }
                
                Divider()
                
                HStack {
                    Image(systemName: "calendar")
                        .fontWeight(.bold)
                    Text("Timestamp:")
                        .fontWeight(.semibold)
                        .opacity(0.8)
                    Text(counterEntry.timestamp.formatted(date: .abbreviated, time: .shortened))
                        .fontWeight(.regular)
                        .opacity(0.8)
                }
                .lineLimit(1)
                
                HStack {
                    Image(systemName: "note.text")
                        .fontWeight(.bold)
                    Text("Note:")
                        .fontWeight(.semibold)
                        .opacity(0.8)
                    Text("\(counterEntry.note)")
                        .fontWeight(.regular)
                        .opacity(0.8)
                }
                .lineLimit(1)
            }
            .font(.custom("Menlo", size: 13))
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(LinearGradient(gradient: Gradient(colors: [.counter, .counterHighlight]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .shadow(color: Color(.counterHighlight).opacity(0.4), radius: 10, x: 0, y: 5)
            
            NavigationLink(destination: CounterEntryFormEdit(counterEntry: counterEntry)) {
                EmptyView()
            }
            .opacity(0.0)
        }
    }
}
