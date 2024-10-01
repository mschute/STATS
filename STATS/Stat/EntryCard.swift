import SwiftUI

struct EntryCard: View {
    @Environment(\.colorScheme) var colorScheme
    var statEntry: any Entry
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "\(statEntry.stat?.icon ?? "goforward")")
                        .fontWeight(.bold)
                    Text("\(statEntry.stat?.name ?? "") Entry")
                        .font(.custom("Menlo", size: 16))
                        .fontWeight(.bold)
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1), radius: 3, x: 3, y: 2)
                        .lineLimit(1)
                }
                
                Divider()
                
                if let decimalEntry = statEntry as? DecimalEntry {
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
                }
                
                if let pictureEntry = statEntry as? PictureEntry {
                    if let imageData = pictureEntry.image,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            .frame(maxWidth: 200, maxHeight: 200, alignment: .center)
                            .clipped()
                            .shadow(radius: 5)
                    }
                }
                
                HStack {
                    Image(systemName: "calendar")
                        .fontWeight(.bold)
                    Text("Timestamp:")
                        .fontWeight(.semibold)
                        .opacity(0.8)
                    Text(statEntry.timestamp.formatted(date: .abbreviated, time: .shortened))
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
                    Text("\(statEntry.note)")
                        .fontWeight(.regular)
                        .opacity(0.8)
                }
                .lineLimit(1)
            }
            .entryCardModifier(gradientColor: statEntry.stat?.statColor ?? .cyan, gradientHighlight: statEntry.stat?.gradientHighlight ?? .counterHighlight)
            
            NavigationLink(destination: AnyStat.EntryCardDestination(statEntry: statEntry)) {
                EmptyView()
            }
            .opacity(0.0)
            .navigationTitle("")
        }
    }
}

