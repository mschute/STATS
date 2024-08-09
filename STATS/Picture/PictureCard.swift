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
                            .frame(width: 30, height: 30)
                        
                        VStack(alignment: .leading) {
                            Text(stat.name)
                                .font(.custom("Menlo", size: 15))
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Text("Picture Stat")
                                .fontWeight(.regular)
                        }
                    }
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        if let latestEntry = stat.statEntry
                            .sorted(by: { $0.timestamp > $1.timestamp })
                            .first(where: { $0.image != nil }) {
                            if let imageData = latestEntry.image,
                               let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                    .frame(maxWidth: .infinity, maxHeight: 60, alignment: .trailing)
                                    .clipped()
                                
                                Text("\(latestEntry.timestamp, style: .date)")
                                    .font(.custom("Menlo", size: 10))
                                    .fontWeight(.regular)
                            } else {
                                EmptyView()
                            }
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
            .gradientFilter(gradientColor: .picture, gradientHighlight: .pictureHighlight, cornerRadius: 12)
            
            NavigationLink(destination: PictureDetail(stat: stat)) {
                EmptyView()
            }
            .opacity(0.0)
            .navigationTitle("")
        }
    }
}
