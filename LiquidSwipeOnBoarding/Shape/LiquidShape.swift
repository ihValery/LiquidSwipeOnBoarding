//
//  LiquidShape.swift
//  LiquidSwipeOnBoarding
//
//  Created by Валерий Игнатьев on 03.11.2021.
//

import SwiftUI

struct LiquidShape: Shape {
    var offset: CGSize
    var curvePoint: CGFloat
    
    //Разница видна когда отпускаем стрелку ))) animatableData НУЖЕН!
    //Type 'CGSize' does not conform to protocol 'VectorArithmetic'
    var animatableData: AnimatablePair<CGSize.AnimatableData, CGFloat> {
        get { AnimatablePair(offset.animatableData, curvePoint) }
        set {
            offset.animatableData = newValue.first
            curvePoint = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        // Когда тянем влево
        // Увеличиваем размер как сверху, так и снизу
        // Чтобы он создавал эффект жидкого смахивания
        
        let width = rect.width + (-offset.width > 0 ? offset.width : 0)
        
        //Первое построение формы прямоугольника
        var p = Path()
        p.move(to: CGPoint(x: 0, y: 0))
        p.addLine(to: CGPoint(x: rect.width, y: 0))
        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))

        //из
        let from: CGFloat = 80 + offset.width
        p.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
        
        //Середина между 80 - 180
        var to: CGFloat = 180 + offset.height - offset.width
        to = to < 180 ? 180 : to
        
        let mid: CGFloat = 80 + ((to - 80) / 2)
        p.addCurve(to: CGPoint(x: rect.width, y: to),
                   control1: CGPoint(x: width - curvePoint, y: mid),
                   control2: CGPoint(x: width - curvePoint, y: mid))
        
        return p
    }
}

