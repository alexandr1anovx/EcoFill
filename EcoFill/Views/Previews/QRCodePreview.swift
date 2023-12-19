//
//  QRCodePreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct QRCodePreview: View {
  @Binding var isShowingQRCodePreview: Bool
  var body: some View {
    VStack {
      Text("QR Code Preview")
        .font(.title2).bold()
    }
    .presentationDetents([.height(500)])
    .presentationCornerRadius(15)
    .presentationBackground(.customSystem)
    .presentationDragIndicator(.visible)
  }
}

#Preview {
  QRCodePreview(isShowingQRCodePreview: .constant(true))
}
