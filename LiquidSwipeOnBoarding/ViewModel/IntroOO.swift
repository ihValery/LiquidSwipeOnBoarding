//
//  IntroOO.swift
//  LiquidSwipeOnBoarding
//
//  Created by Валерий Игнатьев on 03.11.2021.
//

import Foundation

class IntroOO: ObservableObject {
    @Published var intros: [IntroDO] = [
        IntroDO(title: "Мы", subTitle: "Анализировали", description: "Много работали, чтобы найти решение.", pic: "picOne", color: .orangeOne),
        IntroDO(title: "Мы", subTitle: "Исследовали", description: "Искали проблемы которые нуждались в решении.", pic: "picTwo", color: .blueOne),
        IntroDO(title: "Мы", subTitle: "Проектировали", description: "Разработали и решили.", pic: "picThree", color: .purpleLightOne)]
}
