//
//  MapStylePreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 18.02.2024.
//

import SwiftUI
import MapKit

struct MapStyleView: View {
    
    // MARK: - Public Properties
    @Binding var mapStyle: MapStyle
    
    // MARK: - Private Properties
    @State private var isStandardSelected = false
    @State private var isHybridSelected = false
    
    var body: some View {
        HStack(spacing: 10) {
            Button("Standard") {
                mapStyle = .standard
                isStandardSelected = true
                isHybridSelected = false
            }
            Button("Hybrid") {
                mapStyle = .hybrid
                isStandardSelected = false
                isHybridSelected = true
            }
        }
        .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
    }
}
