import SwiftUI

//TODO: Need to Add picture functionality
struct PictureEntryForm: View {
    @Bindable var pictureStat: PictureStat
    //TODO: Why is this bindable but I have it for State for passing in stat type elsewhere?
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    //TODO: Create the temp object with blank values rather than individual properties?
    @State var timestamp = Date.now
    @State var note = ""
    
    var body: some View {
        Form(content: {
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            
            TextField("Note", text: $note)
            Button("Add", action: addEntry)
        })
    }
    
    func addEntry() {
        //TODO: Will need to add additional guards if each required field is empty
        //TODO: Add alert that a field is empty if they try to submit with an empty field
        
        let entry = PictureEntry(pictureStat: pictureStat, entryId: UUID(), timestamp: timestamp, note: note)
        pictureStat.statEntry.append(entry)
        
        note = ""
        timestamp = Date.now
        dismiss()
        selectedDetailTab.selectedDetailTab = .history
    }
}

//#Preview {
//    PictureEntryForm()
//}
