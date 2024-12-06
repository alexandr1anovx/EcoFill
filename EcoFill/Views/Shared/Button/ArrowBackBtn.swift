//
//  BackButton.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.10.2024.
//

import SwiftUI

struct ArrowBackBtn: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.backward.circle.fill")
        }
        .font(.title3)
        .buttonStyle(.animated)
        .foregroundStyle(.accent)
    }
}
