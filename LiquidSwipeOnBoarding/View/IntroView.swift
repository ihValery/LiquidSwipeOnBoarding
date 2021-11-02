//
//  IntroView.swift
//  LiquidSwipeOnBoarding
//
//  Created by Валерий Игнатьев on 03.11.2021.
//

import SwiftUI

struct IntroView: View {
    @StateObject private var intro = IntroOO()
    
    var body: some View {
        ZStack {
            //Почему мы используем indices
            //Так как offset обновляеться в реальном времени
            ForEach(intro.intros.indices.reversed(), id: \.self) { item in
                introView(intro: intro.intros[item])
            }
        }
    }
    
    @ViewBuilder
    func introView(intro: IntroDO) -> some View {
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
                    .padding(.top)
                    .frame(width: getRect().width - 100, alignment: .leading)
                    .lineLimit(2)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding([.top, .trailing])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            intro.color
                .ignoresSafeArea()
        )
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
            .preferredColorScheme(.dark)
    }
}
