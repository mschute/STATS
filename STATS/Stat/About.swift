import Foundation
import SwiftUI

struct About: View {
    var body: some View {
        VStack{
            TopBar(title: "ABOUT", topPadding: 20, bottomPadding: 20)
            Form {
                Section(header: Text("About STATS").foregroundColor(.main).fontWeight(.bold)) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("STATS is a customisable personal statistic tracking application. This application will allow you to track a variety of statistics about yourself and your behaviour.")
                        
                        Text("You may utilise the Report feature to view quick statistics and your progress through a chart. These can be used to visualise and inform you of behaviour and progress made.")
                    }
                    .font(.custom("Helvetica-Neue-Medium", size: 17))
                    .tracking(1)
                    .padding()
                }
                
                Section(header: Text("Counter Stats").foregroundColor(.main).fontWeight(.bold)) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("A Counter Stat is a simple stat type that allows you to enter the date and time an action was performed.")
                        Text("This could include taking vitamins, meditation, journaling, studying, watering plants and more.")
                    }
                    .font(.custom("Helvetica-Neue-Medium", size: 17))
                    .tracking(1)
                    .padding()
                }
                
                Section(header: Text("Decimal Stats").foregroundColor(.main).fontWeight(.bold)) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("The Decimal Stat allows you to collect quantities and measurements about yourself.")
                        Text("This could include tracking actions or facts such as weight, height, money saved, calorie counting, distance run, weight training measurements and more.")
                        Text("This stat type allows you to track totals and/or averages which will alter how data is viewed in the report.")
                    }
                    .font(.custom("Helvetica-Neue-Medium", size: 17))
                    .tracking(1)
                    .padding()
                }
                
                Section(header: Text("Picture Stats").foregroundColor(.main).fontWeight(.bold)) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("The Picture Stat allows you to visualise progress through photos.")
                        Text("You may either upload photos from your photo library or to take a photo from within the application.")
                        Text("In the report, you may pair these photos with a tracked counter or decimal stat. This could include pairing weight with an associated body photo, the use of a skincare product with the visual look of the skin, the number of days into a remodel and the look of room and more.")
                    }
                    .font(.custom("Helvetica-Neue-Medium", size: 17))
                    .tracking(1)
                    .padding()
                }
            }
        }
        .globalBackground()
    }
}
