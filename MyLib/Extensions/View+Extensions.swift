//
//  View+Extensions.swift
//  MyLib
//
//  Created by Matej Malesevic on 23.05.22.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
