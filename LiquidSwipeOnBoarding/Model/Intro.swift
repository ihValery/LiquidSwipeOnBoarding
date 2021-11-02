//
//  Intro.swift
//  LiquidSwipeOnBoarding
//
//  Created by Валерий Игнатьев on 03.11.2021.
//

import SwiftUI

struct IntroDO: Identifiable {
    var id = UUID().uuidString
    var title: String
    var subTitle: String
    var description: String
    var pic: String
    var color: Color
    var offset: CGSize = .zero
}
