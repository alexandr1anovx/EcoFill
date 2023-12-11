//
//  ProductCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct ProductCell: View {
  let product: Product
  
  var body: some View {
    HStack(spacing:20) {
      Image(systemName: "fuelpump")
        .resizable()
        .scaledToFill()
        .frame(width: 23, height: 23)
        .foregroundStyle(.customSystemReversed)
        .opacity(0.8)
      
      VStack(alignment: .leading, spacing: 10) {
        Text(product.title)
          .font(.headline)
          .fontDesign(.rounded)
          .foregroundStyle(.customGreen)
        
        Text("Tap to get details.")
          .font(.subheadline)
          .fontDesign(.rounded)
          .foregroundStyle(.gray)
          .multilineTextAlignment(.leading)
      }
      
      Spacer()
      
      Text("₴\(product.price, specifier: "%.2f")")
        .font(.headline)
        .fontWeight(.medium)
        .foregroundStyle(.customSystemReversed)
    }
  }
}

#Preview {
  ProductCell(product: testProducts[0])
}
