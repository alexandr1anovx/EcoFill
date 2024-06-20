//
//  HomeView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI

struct HomeScreen: View {
  
  // MARK: - properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  @State private var isPresentedQR = false
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      if let city = authenticationVM.currentUser?.city {
        VStack {
          UserDataView()
          FuelsList(selectedCity: city)
            .padding(.vertical, 15)
            .padding(.leading, 20)
            .padding(.trailing, 8)
          ServicesList()
        }
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            Image(.logo)
              .navBarSize()
          }
          
          ToolbarItem(placement: .topBarTrailing) {
            Button {
              isPresentedQR = true
            } label: {
              Image(.qr)
                .navBarSize()
            }
            .buttonStyle(.animated)
            
            .sheet(isPresented: $isPresentedQR) {
              QRCodeView()
                .presentationDetents([.fraction(0.4)])
                .presentationBackgroundInteraction(.disabled)
                .presentationCornerRadius(20)
            }
          }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
      }
    }
  }
}
