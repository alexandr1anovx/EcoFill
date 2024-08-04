//
//  InformationRow.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 12.03.2024.
//

import SwiftUI

struct InformationRow: View {
    
    // MARK: - Private Properties
    let img: ImageResource
    let text: String
    let content: String?
    
    // MARK: - body
    var body: some View {
        HStack(spacing: 10) {
            Image(img)
                .defaultSize()
            Text(text)
                .font(.lexendFootnote)
                .foregroundStyle(.gray)
            Text(content ?? "")
                .font(.lexendFootnote)
                .foregroundStyle(.cmReversed)
        }
    }
}
