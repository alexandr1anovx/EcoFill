//
//  MapControls.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 09.03.2024.
//

import SwiftUI

struct MapControls: View {
    
    // MARK: - Public Properties
    @Binding var isPresentedList: Bool
    @Binding var isPresentedMapStyle: Bool
    
    // MARK: - body
    var body: some View {
        VStack(spacing: 10) {
            MapControlItem(img: .map) { isPresentedMapStyle = true }
            MapControlItem(img: .location) { isPresentedList = true }
        }
    }
}

struct MapControlItem: View {
    
    // MARK: - Public Properties
    let img: ImageResource
    let action: () -> Void?
    
    // MARK: - body
    var body: some View {
        Button {
            action()
        } label: {
            Image(img).defaultSize()
        }
        .buttonStyle(CustomButtonModifier(pouring: .cmSystem))
        .shadow(radius: 5)
    }
}
