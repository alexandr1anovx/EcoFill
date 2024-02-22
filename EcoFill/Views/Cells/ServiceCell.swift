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
  
  var body: some View {
    NavigationLink {
      switch service.title {
      case Service.ServiceType.support.rawValue: SupportScreen()
      case Service.ServiceType.food.rawValue: EmptyView()
      default: EmptyView()
      }
    } label: {
      HStack(spacing: 15) {
        Image(systemName: service.imageName)
          .font(.title)
          .foregroundStyle(.accent)
        
        VStack(alignment: .leading, spacing: 8) {
          Text(service.title)
            .font(.callout)
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .foregroundStyle(.defaultReversed)
          
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
                               imageName: "24.square.fill"))
}
