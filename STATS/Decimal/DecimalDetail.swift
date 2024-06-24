//
//  DecimalDetail.swift
//  STATS
//
//  Created by Staff on 16/06/2024.
//

import SwiftUI

struct DecimalDetail: View {
    var stat: DecimalStat
    
    var body: some View {
        Text("Item at \(stat.name)")
    }
    
    init(stat: DecimalStat) {
        self.stat = stat
    }
}

#Preview {
    DecimalDetail(stat: DecimalStat(name: "Weight", created: Date(), unitName: "KG"))
}
