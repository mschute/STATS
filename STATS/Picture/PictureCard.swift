import SwiftUI

struct PictureCard: View {
    var stat: PictureStat
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    HStack(alignment: .top, spacing: 15) {
                        Image(systemName: stat.icon != "network" ? stat.icon : "camera.circle.fill")
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
                        if let lastEntry = stat.statEntry.last,
                           let imageData = lastEntry.image,
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                .frame(maxWidth: .infinity, maxHeight: 60, alignment: .trailing)
                                .clipped()
                                
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
            .font(.custom("Menlo", size: 13))
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .gradientFilter(gradientColor: .picture, gradientHighlight: .pictureHighlight, cornerRadius: 12)
//            .background(LinearGradient(gradient: Gradient(colors: [.picture, .pictureHighlight]), startPoint: .top, endPoint: .bottom))
//            .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous))
//            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
//            .overlay(
//                RoundedRectangle(cornerRadius: 12)
//                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
//            )
//            .shadow(color: Color(.pictureHighlight).opacity(0.4), radius: 10, x: 0, y: 5)
            
            NavigationLink(destination: PictureDetail(stat: stat)) {
                EmptyView()
            }
            .opacity(0.0)
            .navigationTitle("")
        }
    }
}
