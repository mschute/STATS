import Charts
import SwiftUI

struct PictureReport: View {
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    private var pictureStat: PictureStat

    @State var pictureData: [PictureData] = []
    
    @State var filteredPictureData: [PictureData] = []
    
    @State var total: Int = 0
    
    //@Query(sort: \Category.name) var categories: [Category]
    
    @State var data: [CountDayData] = []
    
    init(pictureStat: PictureStat) {
        self.pictureStat = pictureStat
        _startDate = State(initialValue: pictureStat.created)
        _total = State(initialValue: ReportUtility.calcTotalEntries(stat: pictureStat, startDate: startDate, endDate: endDate))
    }

    var body: some View {
        VStack {
            Text("Report")
                .font(.largeTitle)
            
            ScrollView {
                DateRangePicker(startDate: $startDate, endDate: $endDate)
                    .onChange(of: startDate, initial: true) { updateCalcs() }
                    .onChange(of: endDate, initial: true) { updateCalcs() }
                    .padding()
                
                VStack {
                    Text("Total entries in date range: \(total)")
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(filteredPictureData) { entry in
                                VStack(spacing: 20) {
                                    if let imageData = entry.image, let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: 250, maxHeight: 250)
                                            .clipped()
                                    }

                                    Text("\(entry.timestamp.formatted(date: .abbreviated, time: .shortened))")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    //TODO: Need a nested ForEach loop with the other stats values
                                    //TODO: Need if statement that if the day in the timestamp matches then put an overlay on the photo
                                    //TODO: Need to create an overlay on the photos
                                }
                            }
                        }
                    }
                }
                //TODO: Fixed size appears to be funky
                
                //TODO: Need a dropdown menu of different Stats - Just the names
                //TODO: Need an overlay of the decimal value on top of the picture
                //TODO: How would I do count? Entry count? Since started? Both?
                
            }
            .padding(.horizontal)
            
            //Need function to compare startOfDay between two stat types?
        }
        .onAppear { pictureData = createPictureData(pictureStat: pictureStat) }
    }
    
    private func updateCalcs() {
        total = ReportUtility.calcTotalEntries(stat: pictureStat, startDate: startDate, endDate: endDate)
        filteredPictureData = filterPictureData(pictureData: pictureData, startDate: startDate, endDate: endDate)
    }
    
    func filterPictureData(pictureData: [PictureData], startDate: Date, endDate: Date) -> [PictureData] {
        return pictureData.filter { $0.timestamp >= startDate && $0.timestamp <= endDate }
    }
    
    func createPictureData(pictureStat: PictureStat) -> [PictureData] {
        var newPictureDataArray: [PictureData] = []
        
        for entry in pictureStat.statEntry {
            if let unwrappedImage = entry.image {
                let newPictureData = PictureData(id: UUID(), timestamp: entry.timestamp, image: unwrappedImage)
                newPictureDataArray.append(newPictureData)
            }
        }
        
        return newPictureDataArray.sorted { $0.timestamp < $1.timestamp}
    }
}




//#Preview {
//    CounterReport()
//}
