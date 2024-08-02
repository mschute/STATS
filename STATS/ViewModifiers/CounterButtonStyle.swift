import SwiftUI

struct CounterButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(.counter))
            .foregroundStyle(.black)
            .clipShape(Capsule())
        
    }
}

//#Preview {
//    CounterButton()
//}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: CounterStat.self, DecimalStat.self, PictureStat.self, configurations: config)
//
//        return CounterButton() as! (any View)
//        
//    } catch {
//        fatalError("Failed to create model container.")
//    }
//}
