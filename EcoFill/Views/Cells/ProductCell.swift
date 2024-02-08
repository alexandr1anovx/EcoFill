//
//  ProductCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct ProductCell: View {
  // MARK: - Properties
  let product: Product
  
  // MARK: - body
  var body: some View {
    VStack(alignment: .leading, spacing:13) {
      HStack(spacing:13) {
        Text(product.title)
          .font(.headline)
          .fontDesign(.rounded)
          .foregroundStyle(.accent)
        
        RoundedRectangle(cornerRadius: 8)
          .fill(.defaultSystem)
          .frame(width: 80, height: 35, alignment: .center)
          .overlay {
            Text("₴\(product.price, specifier: "%.2f")")
              .font(.callout)
              .foregroundStyle(.defaultReversed)
              .fontWeight(.medium)
          }
      }
      Text(product.description)
        .font(.footnote)
        .foregroundStyle(.gray)
    }
  }
}

#Preview {
  ProductCell(product: Product(title: "A-92", description: "Description", price: 53.50))
}
