//
//  ContentView.swift
//  Drawing
//
//  Created by Luis Alvarez on 1/1/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Triangle()
            .fill(Color.blue)
            .frame(width: 300, height: 300)
        Arc(startAngle: .degrees(0), endAngle: .degrees(90), clockwise: true)
            .strokeBorder(Color.blue, lineWidth: 40)
            .frame(width: 300, height: 300)
        //Circle()
            //.stroke(Color.blue, lineWidth: 40) Border goes outside of view
        Circle()
            .strokeBorder(Color.blue, lineWidth: 40)
        
        Star()
            //.fill(Color.blue)
            .stroke(Color.blue, lineWidth: 5)
            .frame(width: 300, height: 300)
            
    
    }
    
    
}


struct Triangle: Shape { // Creates a triangle of any size based on rectangle
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

    
// InsettableShape IS a shape, no need to implement both
struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount:CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90) // needed to make angles more intuitive in swiftUI
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}


// Personal Challenge:
//  Draw a star


struct Star:Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY - rect.midY / 2))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY - rect.midY / 2))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY - rect.midY / 2))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - rect.midY / 2))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - rect.midY / 2))
        
        
        
        
        
        return path
    }
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
