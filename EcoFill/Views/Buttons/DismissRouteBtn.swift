//
//  DismissRouteBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 15.06.2024.
//

import SwiftUI

struct DismissRouteBtn: View {
    
    // MARK: - Public Properties
    let action: () -> Void
    
    // MARK: - body
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(.xmark)
                    .defaultSize()
                    .foregroundStyle(.white)
                Text("Dismiss")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(CustomButtonModifier(pouring: .red))
        .shadow(radius: 5)
    }
}
