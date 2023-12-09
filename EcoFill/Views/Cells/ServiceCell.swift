//
//  ServiceCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.
//

import SwiftUI

struct ServiceCell: View {
  var service: Service
  
  var body: some View {
    NavigationLink {
      switch service.title {
      case "Наші продукти": ProductsList()
      case "Новини": EmptyView()
      case "Фідбек": EmptyView()
      case "Наш сайт": EmptyView()
      default: EmptyView()
      }
    } label: {
      HStack(spacing:20) {
        Image(systemName: service.image)
          .resizable()
          .scaledToFit()
          .frame(width: 23, height: 23)
          .foregroundStyle(.customSystemReversed)
          .opacity(0.8)
        
        VStack(alignment: .leading, spacing: 10) {
          Text(service.title)
            .font(.callout)
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .foregroundStyle(.customGreen)
          
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
  ServiceCell(service: services[0])
}
