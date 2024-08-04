//
//  ProfileScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI

struct ProfileScreen: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    
    // MARK: - Private Properties
    @State private var isPresentedSignOut = false
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            UserDataView()
            List {
                AppearanceChanger()
                Button {
                    isPresentedSignOut.toggle()
                } label: {
                    HStack(spacing: 15) {
                        Image(.userDelete)
                            .resizable()
                            .frame(width: 26, height: 26)
                        Text("Sign Out")
                            .font(.lexendBody)
                            .foregroundStyle(.red)
                    }
                }
                .confirmationDialog("", isPresented: $isPresentedSignOut) {
                    Button("Sign Out", role: .destructive) {
                        authenticationVM.signOut()
                    }
                }
            }
            .listStyle(.insetGrouped)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(.logo)
                        .navBarSize()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        UserPrivateDataView()
                    } label: {
                        Image(.edit)
                            .navBarSize()
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
