//
//  ResetEmailBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 02.04.2024.
//

import SwiftUI

struct ResetBtn: View {
    
    // MARK: - Public Properties
    let img: ImageResource
    let data: String
    let action: () -> Void
    
    // MARK: - body
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(img)
                    .defaultSize()
                Text("Reset \(data)")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
        .shadow(radius: 5)
    }
}
