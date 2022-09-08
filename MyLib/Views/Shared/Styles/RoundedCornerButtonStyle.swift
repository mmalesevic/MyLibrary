//
//  RoundedCornerButtonStyle.swift
//  MyLib
//
//  Created by Matej Malesevic on 12.06.22.
//

import SwiftUI

struct RoundedCordnerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.Secondary)
            .foregroundColor(.Primary)
            .cornerRadius(25, corners: .allCorners)
    }
}
