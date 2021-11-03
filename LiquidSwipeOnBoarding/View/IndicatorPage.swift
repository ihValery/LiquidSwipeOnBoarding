//
//  IndicatorPage.swift
//  LiquidSwipeOnBoarding
//
//  Created by Валерий Игнатьев on 03.11.2021.
//

import SwiftUI

struct IndicatorPage: View {
    var count: Int
    @Binding var currentIndex: Int
    
    var body: some View {
        HStack(spacing: 8 ) {
            ForEach(0..<count) { index in
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
}
