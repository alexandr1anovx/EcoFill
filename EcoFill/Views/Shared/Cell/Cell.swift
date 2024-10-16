//
//  Cell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 16.10.2024.
//

import SwiftUI

struct Cell: View {
    let title: String
    let description: String
    let image: String
    let imageColor: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Image(image)
                .defaultImageSize
                .foregroundStyle(imageColor)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.poppins(.medium, size: 14))
                    .foregroundStyle(.primaryBackgroundReversed)
                Text(description)
                    .font(.poppins(.regular, size: 12))
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}
