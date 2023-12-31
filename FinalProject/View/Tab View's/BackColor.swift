//
//  SwiftUIView.swift
//  FinalProject
//
//  Created by ساره المرشد on 15/06/2023.
//
import SwiftUI

struct GradientBackground: View {
    let startColor: Color
    let endColor: Color
    let startPoint: UnitPoint
    let endPoint: UnitPoint
    
    var body: some View {
        let gradient = Gradient(colors: [startColor, endColor])
        return LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint)
            .ignoresSafeArea()
    }
}

struct BackColor: View {
    var body: some View {
        GradientBackground(startColor: Color("CG"), endColor: Color("BG"), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}



struct BackColor_Previews: PreviewProvider {
    static var previews: some View {
        BackColor()
    }
}
