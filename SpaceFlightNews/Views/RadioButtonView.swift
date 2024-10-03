//
//  RadioButtonView.swift
//  SpaceFlightNews
//
//  Created by Jacob Andrean on 02/10/24.
//

import SwiftUI

struct RadioButtonView: View {
    let option: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(option)
            Spacer()
            Circle()
                .stroke(isSelected ? Color.blue : Color.gray, lineWidth: 2)
                .frame(width: 20, height: 20)
                .overlay(
                    Circle()
                        .fill(isSelected ? Color.blue : Color.clear)
                        .frame(width: 10, height: 10)
                )
        }
        .padding(.vertical, 5)
        .background(.white)
        .onTapGesture {
            action()
        }
    }
}
