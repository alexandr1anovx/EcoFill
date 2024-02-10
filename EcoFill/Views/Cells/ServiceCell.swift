//
//  ServiceCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.
//

import SwiftUI

struct ServiceCell: View {
  // MARK: - Properties
  var service: Service
  
  // MARK: - body
  var body: some View {
    NavigationLink {
      switch service.title {
      case Service.ServiceType.products.rawValue: ProductsList()
      case Service.ServiceType.support.rawValue: SupportScreen()
      case Service.ServiceType.food.rawValue: QRCodePreview()
      default: EmptyView()
      }
    } label: {
      HStack(spacing:15) {
        Image(systemName: service.image)
          .font(.title)
          .foregroundStyle(.defaultOrange)
        
        VStack(alignment: .leading, spacing:8) {
          Text(service.title)
            .font(.callout)
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .foregroundStyle(.accent)
          
          Text(service.description)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.leading)
        }
      }
    }
  }
}

#Preview {
  ServiceCell(service: Service(title: "Products",
                               description: "Watch prices.",
                               image: "24.square.fill"))
}
