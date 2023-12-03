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
      
    } label: {
      HStack(spacing:20) {
          Image(systemName: service.image)
              .resizable()
              .scaledToFit()
              .frame(width: 22, height: 22)
              .foregroundStyle(.customSystemReversed)
              .opacity(0.9)
          
          // Product title
          VStack(alignment: .leading, spacing: 8) {
              Text(service.title)
                  .font(.callout)
                  .fontWeight(.semibold)
                  .foregroundStyle(.customGreen)
            // Product description
              Text(service.description)
                  .font(.subheadline)
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
