//
//  HomeView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI

struct HomeScreen: View {
  
  // MARK: - Properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  @State private var isPresentedQR = false
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      if let city = authenticationVM.currentUser?.city {
        VStack {
          UserDataPreview()
            .padding(.top,30)
            .padding(.horizontal,23)
          
          FuelsList(selectedCity: city)
            .padding(.vertical,20)
            .padding(.horizontal,10)
          ServicesList()
        }
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            Image("logo")
              .resizable()
              .frame(width:32, height:32)
          }
          
          ToolbarItem(placement: .topBarTrailing) {
            Button {
              isPresentedQR = true
            } label: {
              Image(systemName: "qrcode.viewfinder")
                .font(.title3)
                .foregroundStyle(.accent)
            }
            .sheet(isPresented: $isPresentedQR) {
              QRCodePreview()
                .presentationDetents([.fraction(0.45)])
                .presentationDragIndicator(.visible)
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

#Preview {
  HomeScreen()
    .environmentObject(AuthenticationViewModel())
    .environmentObject(FirestoreViewModel())
}
