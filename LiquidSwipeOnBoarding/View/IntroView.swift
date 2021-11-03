//
//  IntroView.swift
//  LiquidSwipeOnBoarding
//
//  Created by Валерий Игнатьев on 03.11.2021.
//

import SwiftUI

struct IntroView: View {
    @StateObject private var intro = IntroOO()
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            //Почему мы используем indices
            //Так как offset обновляеться в реальном времени
            ForEach(intro.intros.indices.reversed(), id: \.self) { item in
                introView(intro: intro.intros[item])
                    .clipShape(LiquidShape(offset: offset))
                    .ignoresSafeArea()
                
                    //arrow
                    .overlay(
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(width: 50, height: 50)
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                                            offset = value.translation
                                        }
                                    }
                                    .onEnded { value in
                                        withAnimation(.spring()) {
                                            offset = .zero
                                        }
                                    }
                            )
                            .offset(x: 15, y: 58)
                        ,alignment: .topTrailing
                    )
                    //arrow
                    .padding(.trailing)
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
