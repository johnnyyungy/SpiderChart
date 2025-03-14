//
//  ContentView.swift
//  RadarChart
//
//  Created by Yung Bros on 14/03/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let data = RadarChartData(values: [4, 3, 5, 2, 4], categories: ["A", "B", "C", "D", "E"])
        
        RadarChartView(data: data, maxValue: 5)
            .frame(width: 300, height: 300)
            .padding()
    }
}

#Preview {
    ContentView()
}
