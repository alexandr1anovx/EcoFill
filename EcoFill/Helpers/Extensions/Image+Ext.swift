//
//  Image+Ext.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 11.03.2024.
//

import SwiftUI

extension Image {
    var navBarImageSize: some View {
        self
            .resizable()
            .frame(width: 32, height: 32)
    }
    var defaultImageSize: some View {
        self
            .resizable()
            .frame(width: 23, height: 23)
    }
}
