//
//  MapItemInfoBlock.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.08.2025.
//

import SwiftUI

struct MapItemInfoBlock: View {
  let icon: String
  let title: String
  let value: String
  
  var body: some View {
    VStack(spacing: 7) {
      Image(systemName: icon)
        .font(.title2)
        .foregroundStyle(.green)
      Text(title)
        .font(.footnote)
        .foregroundStyle(.secondary)
      Text(value)
        .font(.subheadline)
        .fontWeight(.bold)
    }
  }
}
