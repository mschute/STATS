import SwiftUI

struct CounterEntryCard: View {

    var body: some View {
        NavigationLink {
            //TODO: Navigate to separate edit form
            //TODO: Need to create separate edit form (Need to do the same Add/Edit switch on the form. Navigate back to history after edit)
        } label: {
            Text("Counter Name")
        }
        Text("Counter Entry Card")
    }
}

#Preview {
    CounterEntryCard()
}
