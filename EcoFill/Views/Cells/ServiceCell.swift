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
      case "Products": ProductsList()
      case "Feedback": FeedbackScreen()
      default: EmptyView()
      }
    } label: {
      HStack(spacing:15) {
        Image(systemName: service.image)
          .imageScale(.large)
          .foregroundStyle(.customSystemReversed)
          .opacity(0.8)
        
        VStack(alignment: .leading, spacing:8) {
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
