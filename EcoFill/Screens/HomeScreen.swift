//
//  HomeView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI

struct HomeScreen: View {
  @State private var isPresentedQR: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        UserDataPreview()
          .padding(30)
        ServicesList()
      }
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Image("gas-station")
            .resizable()
            .scaledToFill()
            .frame(width: 30, height: 30)
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          Button("QR", systemImage: "qrcode") {
            isPresentedQR.toggle()
          }
          .sheet(isPresented: $isPresentedQR) {
            QRCodePreview()
              .presentationDetents([.medium])
              .presentationDragIndicator(.visible)
              .presentationBackgroundInteraction(.enabled(upThrough: .large))
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
