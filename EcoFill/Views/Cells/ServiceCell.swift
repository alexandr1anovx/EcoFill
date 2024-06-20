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
      switch service.type {
      case .support:
        SupportScreen()
      }
    } label: {
      HStack(spacing: 15) {
        Image(systemName: service.imageName)
          .font(.title)
          .foregroundStyle(.accent)
        
        VStack(alignment: .leading, spacing: 8) {
          Text(service.title)
            .font(.lexendCallout)
            .foregroundStyle(.cmReversed)
          
          Text(service.description)
            .font(.lexendCaption)
            .foregroundStyle(.gray)
            .multilineTextAlignment(.leading)
        }
      }
    }
  }
}

