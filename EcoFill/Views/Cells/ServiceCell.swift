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
      case "Products": ProductsList()
      case "Support": SupportScreen()
      default: EmptyView()
      }
    } label: {
      HStack(spacing:15) {
        Image(systemName: service.image)
          .imageScale(.medium)
          .foregroundStyle(.defaultReversed)
        
        VStack(alignment: .leading, spacing:8) {
          Text(service.title)
            .font(.callout)
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .foregroundStyle(.accent)
          
          Text(service.description)
            .font(.caption)
            .fontDesign(.rounded)
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
                               image: "fuelpump"))
}
