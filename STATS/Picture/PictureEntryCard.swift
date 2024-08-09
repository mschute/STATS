import SwiftUI

struct PictureEntryCard: View {
    @Environment (\.colorScheme) var colorScheme
    var pictureEntry: PictureEntry
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "\(pictureEntry.stat?.icon ?? "photo")")
                        .fontWeight(.bold)
                    Text("\(pictureEntry.stat?.name ?? "") Entry")
                        .font(.custom("Menlo", size: 16))
                        .fontWeight(.bold)
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1), radius: 3, x: 3, y: 2)
                        .lineLimit(1)
                }
                Divider()
                
                HStack {
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
                    Text(pictureEntry.timestamp.formatted(date: .abbreviated, time: .shortened))
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
                    Text("\(pictureEntry.note)")
                        .fontWeight(.regular)
                        .opacity(0.8)
                }
                .lineLimit(1)
            }
            .font(.custom("Menlo", size: 13))
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .gradientFilter(gradientColor: .picture, gradientHighlight: .pictureHighlight, cornerRadius: 12)
            
            NavigationLink(destination:
                            PictureEntryFormEdit(pictureEntry: pictureEntry)) {
                EmptyView()
            }
            .opacity(0.0)
        }
    }
}
