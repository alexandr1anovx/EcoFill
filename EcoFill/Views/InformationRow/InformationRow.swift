//
//  InformationRow.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 12.03.2024.
//

import SwiftUI

struct InformationRow: View {
  let img: ImageResource
  let text: String
  let content: String?
  
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

#Preview {
  InformationRow(
    img: .initials, text: "Initials:", content: "Tim Cook")
}

