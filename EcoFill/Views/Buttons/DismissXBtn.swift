//
//  DismissXButton.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 09.03.2024.
//

import SwiftUI

struct DismissXBtn: View {
    
    // MARK: - Public Properties
    @Environment(\.dismiss) var dismiss
    
    // MARK: - body
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(.xmark)
                .defaultSize()
        }
    }
}
