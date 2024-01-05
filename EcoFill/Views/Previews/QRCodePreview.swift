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
    .presentationDetents([.height(400)])
    .presentationCornerRadius(15)
    .presentationBackground(.defaultBackground)
    .presentationDragIndicator(.visible)
  }
}

#Preview {
  QRCodePreview(isShowingQRCodePreview: .constant(true))
}
