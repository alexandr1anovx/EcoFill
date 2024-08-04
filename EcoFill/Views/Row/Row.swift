//
//  Row.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 19.06.2024.
//

import Foundation
import SwiftUI

struct Row: View {
    
    // MARK: - Public Properties
    let img: ImageResource
    let text: String?
    
    // MARK: - body
    var body: some View {
        HStack {
            Image(img)
                .defaultSize()
            Text(text ?? "")
                .font(.lexendFootnote)
                .foregroundStyle(.gray)
        }
    }
}
