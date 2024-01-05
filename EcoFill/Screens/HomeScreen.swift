//
//  HomeView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI

struct HomeScreen: View {
  @State private var isPresentedQR:Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        UserDataPreview()
          .padding(30)
        ServicesList()
      }
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          Button("QR", systemImage: "qrcode") {
            isPresentedQR.toggle()
          }
          .buttonStyle(.borderless)
          .sheet(isPresented: $isPresentedQR) {
            QRCodePreview(isShowingQRCodePreview: $isPresentedQR)
          }
        }
      }
      .navigationTitle("Home")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  HomeScreen()
    .environmentObject(AuthViewModel())
}
