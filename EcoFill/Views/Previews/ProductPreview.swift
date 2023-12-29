//
//  ProductPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct ProductPreview: View {
  let product: Product
  
  var body: some View {
    VStack(alignment: .center, spacing:20) {
      Text(product.title)
        .font(.system(size: 19,
                      weight: .medium,
                      design: .rounded))
        .foregroundStyle(.customGreen)
      
      Divider()
      
      Text(product.description)
        .font(.subheadline)
        .foregroundStyle(.gray)
        .multilineTextAlignment(.leading)
    }
    .padding(.horizontal,20)
    
    .presentationDetents([.height(200)])
    .presentationBackgroundInteraction(.enabled(upThrough: .height(200)))
    .presentationCornerRadius(20)
    .presentationDragIndicator(.visible)
  }
}
