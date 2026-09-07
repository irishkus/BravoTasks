//
//  StarPath.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 31.05.2026.
//

import SwiftUI

struct StarPath: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 32.37, y: 25.73))

            path.addQuadCurve(
                to: CGPoint(x: 64.63, y: 25.73),
                control: CGPoint(x: 50, y: 0)
            )

            path.addQuadCurve(
                to: CGPoint(x: 78.53, y: 59.27),
                control: CGPoint(x: 96.55, y: 34.55)
            )

            path.addQuadCurve(
                to: CGPoint(x: 50, y: 80),
                control: CGPoint(x: 79.39, y: 90.45)
            )
            
            path.addQuadCurve(
                to: CGPoint(x: 21.47, y: 59.27),
                control: CGPoint(x: 20.61, y: 90.45)
            )

            path.addQuadCurve(
                to: CGPoint(x: 32.37, y: 25.73),
                control: CGPoint(x: 2.45, y: 34.66)
            )
            path.closeSubpath()
        }
        .fill(LinearGradient(gradient: Gradient(colors: [
            Color.bravoStarYellowOrange,
            Color.bravoStarOrangeDeep
        ]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

#Preview {
    StarPath()
}
