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
        ToolbarItemGroup(placement: .topBarTrailing) {
          Link(destination: URL(string: "https://www.apple.com")!) {
            Label("Website", systemImage: "globe")
          }
          .tint(.customBlack)
          
          Button {
            isShowingQRCodePreview.toggle()
          } label: {
            Label("QR", systemImage: "qrcode")
          }
          .tint(.customBlack)
          .sheet(isPresented: $isShowingQRCodePreview) {
            QRCodePreview(isShowingQRCodePreview: $isShowingQRCodePreview)
          }
        }
      }
    }
  }
}

#Preview {
  HomeScreen()
}
