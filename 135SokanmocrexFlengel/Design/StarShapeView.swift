//
//  StarShapeView.swift
//  135SokanmocrexFlengel
//

import SwiftUI

struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        var path = Path()
        let points = 5
        let angleAdjustment = CGFloat.pi / 2
        for i in 0..<(points * 2) {
            let angle = CGFloat(i) * .pi / CGFloat(points) - angleAdjustment
            let r = i.isMultiple(of: 2) ? radius : radius * 0.45
            let pt = CGPoint(x: center.x + cos(angle) * r, y: center.y + sin(angle) * r)
            if i == 0 { path.move(to: pt) } else { path.addLine(to: pt) }
        }
        path.closeSubpath()
        return path
    }
}

struct GlowingStarView: View {
    let filled: Bool
    let size: CGFloat
    @State private var scale: CGFloat = 0.01
    @State private var appeared = false

    var body: some View {
        StarShape()
            .fill(filled ? Color.appAccent : Color.appSurface.opacity(0.6))
            .frame(width: size, height: size)
            .scaleEffect(scale)
            .shadow(color: filled ? Color.appAccent.opacity(0.85) : .clear, radius: filled ? 12 : 0)
            .shadow(color: filled ? Color.appPrimary.opacity(0.45) : .clear, radius: filled ? 6 : 0)
            .onAppear {
                guard !appeared else { return }
                appeared = true
                withAnimation(.spring(response: 0.55, dampingFraction: 0.62)) {
                    scale = 1
                }
            }
    }
}
