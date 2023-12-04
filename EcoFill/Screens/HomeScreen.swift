//
//  HomeView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI

struct HomeScreen: View {
  @State private var isShowingQRCodePreview: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        UserDataPreview()
        ServicesList()
          .padding(.top, 15)
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("", systemImage: "qrcode") {
            isShowingQRCodePreview.toggle()
          }
          .tint(.customGreen)
          .sheet(isPresented: $isShowingQRCodePreview) {
            QRCodePreview(isShowingQRCodePreview: $isShowingQRCodePreview)
              .presentationDetents([.height(500)])
              .presentationCornerRadius(15)
              .presentationBackground(.customSystem)
              .interactiveDismissDisabled(true)
          }
        }
      }
    }
  }
}

#Preview {
  HomeScreen()
}
