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
    NavigationStack {
      VStack {
        Text("QR Code Preview")
          .font(.title2).bold()
      }
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          CancellationButton { isShowingQRCodePreview = false }
        }
      }
    }
  }
}

#Preview {
  QRCodePreview(isShowingQRCodePreview: .constant(true))
}
