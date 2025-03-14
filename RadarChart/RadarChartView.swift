//
//  RadarChartView.swift
//  RadarChart
//
//  Created by Yung Bros on 14/03/2025.
//

import SwiftUI

struct RadarChartView: View {
    var data: RadarChartData
    var maxValue: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Draw the background grid
                RadarGrid(categories: data.categories, levels: 5)
                    .stroke(Color.gray, lineWidth: 1)
                
                // Draw the data shape
                RadarShape(values: data.values, maxValue: maxValue)
                    .fill(Color.blue.opacity(0.3))
                    .overlay(
                        RadarShape(values: data.values, maxValue: maxValue)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
        }
    }
}

struct RadarGrid: Shape {
    var categories: [String]
    var levels: Int
    
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var path = Path()
        
        // Draw straight lines for levels
        for level in 1...levels {
            let levelRadius = radius * CGFloat(level) / CGFloat(levels)
            
            for (index, _) in categories.enumerated() {
                let angle = 2 * .pi * CGFloat(index) / CGFloat(categories.count) - .pi / 2
                let x = center.x + levelRadius * cos(angle)
                let y = center.y + levelRadius * sin(angle)
                
                if index == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            
            // Close the path to form a polygon
            path.closeSubpath()
        }
        
        // Draw the category lines
        for (index, category) in categories.enumerated() {
            let angle = 2 * .pi * CGFloat(index) / CGFloat(categories.count) - .pi / 2
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            path.move(to: center)
            path.addLine(to: CGPoint(x: x, y: y))
            
            // Add category labels
            let labelX = center.x + (radius + 10) * cos(angle)
            let labelY = center.y + (radius + 10) * sin(angle)
            Text(category)
                .position(x: labelX, y: labelY)
                .font(.caption)
        }
        
        return path
    }
}

struct RadarShape: Shape {
    var values: [Double]
    var maxValue: Double
    
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var path = Path()
        
        for (index, value) in values.enumerated() {
            let angle = 2 * .pi * CGFloat(index) / CGFloat(values.count) - .pi / 2
            let x = center.x + radius * CGFloat(value / maxValue) * cos(angle)
            let y = center.y + radius * CGFloat(value / maxValue) * sin(angle)
            
            if index == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        path.closeSubpath()
        return path
    }
}


