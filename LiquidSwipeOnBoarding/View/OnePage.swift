//
//  OnePage.swift
//  LiquidSwipeOnBoarding
//
//  Created by Валерий Игнатьев on 03.11.2021.
//

import SwiftUI

struct OnePage: View {
    var intro: IntroDO
    
    var body: some View {
        VStack {
            Image(intro.pic)
                .resizable()
                .scaledToFit()
                .padding(40)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(intro.title)
                    .font(.largeTitle)
                
                Text(intro.subTitle)
                    .font(.largeTitle).bold()
                
                Text(intro.description)
                    .font(.title3)
                    .frame(width: getRect().width - 100, alignment: .leading)
                    .lineLimit(3)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding([.top, .trailing])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(intro.color)
    }
}
