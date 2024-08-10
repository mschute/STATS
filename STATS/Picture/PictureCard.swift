import SwiftUI

struct PictureCard: View {
    var stat: PictureStat
    
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
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Text("Picture Stat")
                                .font(.custom("Menlo", size: 14))
                                .fontWeight(.regular)
                        }
                    }
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 8) {
                        if let latestEntry = stat.statEntry
                            .sorted(by: { $0.timestamp > $1.timestamp })
                            .first(where: { $0.image != nil }) {
                            if let imageData = latestEntry.image,
                               let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
                                    .clipped()
                                
                                Text("\(latestEntry.timestamp, style: .date)")
                                    .font(.custom("Menlo", size: 12))
                                    .fontWeight(.regular)
                            } else {
                                EmptyView()
                            }
                        } else {
                            Text("No entries")
                                .fontWeight(.medium)
                        }
                    }
                    .frame(maxWidth: 110)
                }
            }
            .font(.custom("Menlo", size: 13))
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .gradientFilter(gradientColor: .picture, gradientHighlight: .pictureHighlight, cornerRadius: 12)
            
            NavigationLink(destination: PictureDetail(stat: stat)) {
                EmptyView()
            }
            .opacity(0.0)
            .navigationTitle("")
        }
    }
}
