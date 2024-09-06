import SwiftUI

struct PictureCardLatestEntry: View {
    var stat: PictureStat
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            if (stat.statEntry.isEmpty) {
                Text("No entries")
                    .font(.custom("Menlo", size: 13))
                    .fontWeight(.semibold)
            } else {
                if let latestEntry = stat.statEntry
                    .sorted(by: { $0.timestamp > $1.timestamp })
                    //TODO: Extrat display image
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
