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
    HStack {
      VStack(alignment: .leading, spacing: 12) {
        Label(product.title,systemImage: "fuelpump")
          .font(.headline)
          .fontDesign(.rounded)
          .foregroundStyle(.customGreen)
        
        Label("Show details",systemImage: "hand.tap.fill")
          .font(.footnote)
          .foregroundStyle(.gray)
      }
      
      Spacer()
      
      Text("₴\(product.price, specifier: "%.2f")")
        .font(.headline)
        .fontWeight(.medium)
        .foregroundStyle(.customSystemReversed)
    }
  }
}
