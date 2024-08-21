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
                            Text("Picture Stat")
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
                                .fontWeight(.medium)
                        } else {
                            if let latestEntry = stat.statEntry
                                .sorted(by: { $0.timestamp > $1.timestamp })
                                .first {
                                if let imageData = latestEntry.image,
                                   let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
                                        .clipped()
                                    
                                    Text("\(DateUtility.abbreviatedDateString(date: latestEntry.timestamp))")
                                        .font(.custom("Menlo", size: 12))
                                        .fontWeight(.regular)
                                } else {
                                    RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                                        .fill(Color.gray)
                                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
                                        .clipped()
                                }
                            }
                        }
                    }
                    .frame(maxWidth: 100)
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
