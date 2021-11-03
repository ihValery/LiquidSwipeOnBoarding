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
                                           curvePoint: fakeIndex == index ? 50 : 0))
                    .padding(.trailing, fakeIndex == index ? 15 : 0)
                    .ignoresSafeArea()
            }
            
            HStack(spacing: 8 ) {
                ForEach(0..<intro.intros.count) { index in
                    Circle()
                        .fill(.white)
                        .frame(width: 8, height: 8)
                        .scaleEffect(currentIndex == index ? 1.3 : 1)
                        .opacity(currentIndex == index ? 1 : 0.6)
                }
                
                Spacer()
            }
            .padding(.leading, 30)
            .padding(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
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
                                    intro.intros[fakeIndex].offset = value.translation
                                }
                            }
                            .onEnded { value in
                                withAnimation(.spring()) {
                                    if -intro.intros[fakeIndex].offset.width > getRect().width / 2 {
                                        intro.intros[fakeIndex].offset.width = -getRect().height * 1.5
                                        fakeIndex += 1
                                        
                                        //Обновление оригенального индекса
                                        if currentIndex == intro.intros.count - 3 {
                                            currentIndex = 0
                                        } else {
                                            currentIndex += 1
                                        }
                                        
                                        //Когда fakeindex достигает предпоследнего элемента
                                        //Снова переключаемся на первый елемент, чтобы создать ощущение бесконечной карусели
                                        
                                        //Не большая задержка для завершения анимации смахивания
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                            if fakeIndex == intro.intros.count - 2 {
                                                for i in 0..<intro.intros.count - 2 {
                                                    intro.intros[i].offset = .zero
                                                }
                                                fakeIndex = 0
                                            }
                                        }
                                        
                                    } else {
                                        intro.intros[fakeIndex].offset = .zero
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
        .onAppear {
            //Меняем последний элемент с первым
            //и первый с последним, чтобы создать ощущение бесконечной карусели
            guard let first = intro.intros.first else { return }
            guard var last = intro.intros.last else { return }
            
            last.offset.width = -getRect().height * 1.5
            
            intro.intros.append(first)
            intro.intros.insert(last, at: 0)
            
            fakeIndex = 1
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

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
//            .preferredColorScheme(.dark)
    }
}
