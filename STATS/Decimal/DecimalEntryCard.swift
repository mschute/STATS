import SwiftUI

struct DecimalEntryCard: View {
    @Environment (\.colorScheme) var colorScheme
    var decimalEntry: DecimalEntry
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "\(decimalEntry.stat?.icon ?? "network")")
                        .fontWeight(.bold)
                    Text("\(decimalEntry.stat?.name ?? "") Entry")
                        .font(.custom("Menlo", size: 16))
                        .fontWeight(.bold)
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1), radius: 3, x: 3, y: 2)
                        .lineLimit(1)
                }
                Divider()
                
                HStack {
                    Image(systemName: "number.square")
                        .fontWeight(.bold)
                    Text("Value:")
                        .fontWeight(.semibold)
                        .opacity(0.8)
                    Text("\(String(format: "%.2f", decimalEntry.value)) \(decimalEntry.stat?.unitName ?? "")")
                        .fontWeight(.regular)
                        .opacity(0.8)
                }
                .lineLimit(1)
                
                HStack {
                    Image(systemName: "calendar")
                        .fontWeight(.bold)
                    Text("Timestamp:")
                        .fontWeight(.semibold)
                        .opacity(0.8)
                    Text(decimalEntry.timestamp.formatted(date: .abbreviated, time: .shortened))
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
                    Text("\(decimalEntry.note)")
                        .fontWeight(.regular)
                        .opacity(0.8)
                }
                .lineLimit(1)
            }
            .font(.custom("Menlo", size: 13))
            .padding()
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .gradientFilter(gradientColor: .mint, gradientHighlight: .decimalHighlight, cornerRadius: 12)
            
            NavigationLink(destination: DecimalEntryFormEdit(decimalEntry: decimalEntry))
            {
                EmptyView()
            }
            .navigationTitle("")
            .opacity(0.0)
        }
    }
}
