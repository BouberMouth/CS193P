//
//  Wave.swift
//  Set Game
//
//  Created by Antoine on 26/06/2020.
//  Copyright © 2020 BOUBERBOUCHE Antoine. All rights reserved.
//

import SwiftUI

struct Wave: Shape {
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let size = rect.width
        let sf = size / 104     // scale factor
        let dx = center.x - (70*sf/2) // shift x
        let dy = center.y - (size/2)    // shift y
        
        
        var p = Path()
        p.move(to: CGPoint(x: 15*sf+dx, y: 104*sf+dy))
        p.addCurve(
            to: CGPoint(x: 54*sf+dx, y: 63*sf+dy),
            control1: CGPoint(x: 36.9*sf+dx, y: 112.4*sf+dy),
            control2: CGPoint(x: 60.8*sf+dx, y: 89.7*sf+dy))
        p.addCurve(
            to: CGPoint(x: 53*sf+dx, y: 27*sf+dy),
            control1: CGPoint(x: 51.3*sf+dx, y: 52.3*sf+dy),
            control2: CGPoint(x: 42*sf+dx, y: 42.2*sf+dy))
        p.addCurve(
            to: CGPoint(x: 40*sf+dx, y: 5*sf+dy),
            control1: CGPoint(x: 65.6*sf+dx, y: 9.6*sf+dy),
            control2: CGPoint(x: 58.3*sf+dx, y: 5.4*sf+dy))
        p.addCurve(
            to: CGPoint(x: 12*sf+dx, y: 36*sf+dy),
            control1: CGPoint(x: 22*sf+dx, y: 4.6*sf+dy),
            control2: CGPoint(x: 19.1*sf+dx, y: 9.7*sf+dy))
        p.addCurve(
            to: CGPoint(x: 14*sf+dx, y: 89*sf+dy),
            control1: CGPoint(x: 15.2*sf+dx, y: 59.2*sf+dy),
            control2: CGPoint(x: 31.5*sf+dx, y: 61.9*sf+dy))
        p.addCurve(
            to: CGPoint(x: 15*sf+dx, y: 104*sf+dy),
            control1: CGPoint(x: 10*sf+dx, y: 95.3*sf+dy),
            control2: CGPoint(x: 6.9*sf+dx, y: 100.9*sf+dy))
        

        return p
    }
}



struct Wave_Previews: PreviewProvider {
    static var previews: some View {
        Wave()
    }
}


/*
 p.addArc(
     center: CGPoint(x: center.x - outerArcOffset + centerWidth/2, y: center.y),
     radius: width + centerWidth / 2,
     startAngle: Angle.radians(0),
     endAngle: Angle.degrees(180),
     clockwise: true
 )
 p.addArc(
     center: CGPoint(x: center.x + outerArcOffset - centerWidth/2, y: center.y),
     radius: width + centerWidth / 2,
     startAngle: Angle.radians(0),
     endAngle: Angle.degrees(180),
     clockwise: false
 )
 */

