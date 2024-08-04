//
//  HomeView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI

struct HomeScreen: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    
    // MARK: - Private Properties
    @State private var isPresentedQR = false
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            if let city = authenticationVM.currentUser?.city {
                VStack {
                    UserDataView()
                    FuelsList(selectedCity: city)
                        .padding(.vertical, 15)
                        .padding(.leading, 15)
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
                            isPresentedQR.toggle()
                        } label: {
                            Image(.qr)
                                .navBarSize()
                        }
                        .buttonStyle(.animated)
                    }
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .sheet(isPresented: $isPresentedQR) {
            QRCodeView()
                .presentationDetents([.fraction(0.4)])
                .presentationBackgroundInteraction(.disabled)
                .presentationCornerRadius(20)
        }
    }
}
