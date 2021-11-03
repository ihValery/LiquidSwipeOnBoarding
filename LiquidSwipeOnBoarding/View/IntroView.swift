//
//  IntroView.swift
//  LiquidSwipeOnBoarding
//
//  Created by Валерий Игнатьев on 03.11.2021.
//

import SwiftUI

struct IntroView: View {
    @StateObject private var intro = IntroOO()
    @GestureState private var isDragging: Bool = false
    @State private var fakeIndex: Int = 0
    @State private var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            //Почему мы используем indices...
            //Так как offset обновляеться в реальном времени
            ForEach(intro.intros.indices.reversed(), id: \.self) { index in
                introView(intro: intro.intros[index])
                    .clipShape(LiquidShape(offset: intro.intros[index].offset,
                                           curvePoint: currentIndex == index ? 50 : 0))
                    .padding(.trailing, currentIndex == index ? 15 : 0)
                    .ignoresSafeArea()
            }
        }
        //Стрелка для свайпа
        .overlay(
            Button(action: {
                
            }, label: {
                Image(systemName: "chevron.compact.left")
                    .font(.largeTitle)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    //Определяет форму содержимого для проверки попадания. Не понятно.
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .updating($isDragging) { value, out, _ in
                                out = true
                            }
                            .onChanged { value in
                                //обновляем offset
                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                                    intro.intros[currentIndex].offset = value.translation
                                }
                            }
                            .onEnded { value in
                                withAnimation(.spring()) {
                                    if -intro.intros[currentIndex].offset.width > getRect().width / 2 {
                                        intro.intros[currentIndex].offset.width = -getRect().height * 1.5
                                    } else {
                                        intro.intros[currentIndex].offset = .zero
                                    }
                                }
                            }
                    )
            })
                .offset(x: -6, y: getRect().height > 750 ? 58 : 84)
                .opacity(isDragging ? 0 : 1)
                .animation(.linear, value: isDragging)
            
            ,alignment: .topTrailing
        )
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
        .background(intro.color)
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
//            .preferredColorScheme(.dark)
    }
}
