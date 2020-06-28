//
//  Triangle.swift
//  Set Game
//
//  Created by Antoine on 29/06/2020.
//  Copyright © 2020 BOUBERBOUCHE Antoine. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var center = CGPoint(x: rect.midX, y: rect.midY)
        var height = min(rect.width, rect.height) / 4
        
        var p = Path()
//        var topPoint = CGPoint(x: center.x, y: center.y - height)
//        p.move(to: topPoint)
//        var leftPoint = CGPoint(x: rect.minX, y: center.y)
//        p.addLine(to: leftPoint)
//        var bottomPoint = CGPoint(x: center.x , y: center.y + height)
//        p.addLine(to: bottomPoint)
//        var rightPoint = CGPoint(x: rect.maxX, y: center.y)
//        p.addLine(to: rightPoint)
//        p.addLine(to: topPoint)
        
        return p
    }
}

struct Triangle_Previews: PreviewProvider {
    static var previews: some View {
        Triangle()
            .fill(Color.red)
            .padding()
    }
}

