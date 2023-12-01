//
//  LocationItemPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI
import MapKit

struct LocationItemPreview: View {
  @Binding var selectedMapItem: MKMapItem?
  @Binding var isShowingLocationItemPreview: Bool
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .center, spacing: 20) {
        Text(selectedMapItem?.placemark.name ?? "No placemark name.")
          .font(.headline)
          .foregroundStyle(.customSystemReversed)
        
        Divider()
        
        HStack {
          /// Placemark title shows a street name.
          Text(selectedMapItem?.placemark.title ?? "No placemark title.")
            .font(.subheadline)
            .foregroundStyle(Color.gray)
            .multilineTextAlignment(.leading)
          
          Spacer()
          
          Button("Маршрут", systemImage: "figure.walk") {
            // Action
          }
          .font(.callout)
          .fontWeight(.medium)
          .foregroundStyle(.customGreen)
        }
      }
      .padding(.horizontal, 20)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Скасувати") {
            isShowingLocationItemPreview = false
            selectedMapItem = nil
          }
          .buttonStyle(.bordered)
          .tint(.red)
        }
      }
    }
  }
}

#Preview {
  LocationItemPreview(selectedMapItem: .constant(nil), isShowingLocationItemPreview: .constant(true))
}
