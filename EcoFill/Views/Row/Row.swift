//
//  Row.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 19.06.2024.
//

import Foundation
import SwiftUI

struct Row: View {
  var img: ImageResource
  var text: String?
  
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
