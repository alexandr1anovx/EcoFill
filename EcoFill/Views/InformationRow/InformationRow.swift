//
//  InformationRow.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 12.03.2024.
//

import SwiftUI

struct InformationRow: View {
  
  let image: ImageResource
  let title: String
  let content: String?
  
  var body: some View {
    
    HStack(spacing: 10) {
      Image(image)
        .defaultSize()
      Text(title)
        .font(.lexendFootnote)
        .foregroundStyle(.gray)
      Text(content ?? "")
        .font(.lexendFootnote)
        .foregroundStyle(.cmReversed)
    }
  }
}

#Preview {
  InformationRow(
    image: .initials, title: "Initials:", content: "Tim Cook")
}
