//
//  LocationItemPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI
import MapKit

struct MapItemPreview: View {
  
  @Binding var selectedMapItem: MKMapItem?
  @Binding var isPresentedMapItemPreview: Bool
  
  // MARK: - Body
  
  var body: some View {
    VStack(alignment: .leading, spacing:20) {
      // Displaying a location name (or absence message).
      Text(selectedMapItem?.placemark.name ?? "No placemark name.")
        .font(.system(size: 19,
                      weight: .medium,
                      design: .rounded))
        .foregroundStyle(.customGreen)
      
      Divider()
      
      // Displaying a location title (or absence message).
      Text(selectedMapItem?.placemark.title ?? "No placemark title.")
        .font(.subheadline)
        .foregroundStyle(.gray)
        .multilineTextAlignment(.leading)
    }
    .padding(.horizontal,20)
    
    .presentationDetents([.height(200)]) // The height of the preview
    .presentationBackgroundInteraction(.enabled(upThrough: .height(200))) // Enable background interaction up to a certain height
    .presentationCornerRadius(20)
    .presentationDragIndicator(.visible)
  }
}

// MARK: - Preview

#Preview {
  MapItemPreview(selectedMapItem: .constant(nil), isPresentedMapItemPreview: .constant(true))
}
