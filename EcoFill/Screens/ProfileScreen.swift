//
//  ProfileScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI

struct ProfileScreen: View {
  
  // MARK: - Properties
  @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
  @Environment(\.colorScheme) private var scheme
  @EnvironmentObject var authViewModel: AuthViewModel
  
  @State private var isPresentedLogOutConfirmation: Bool = false
  @State private var changeTheme: Bool = false
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      UserDataPreview()
        .padding(30)
      
      List {
        HStack {
          Label("Appearance", 
                systemImage: "moonphase.waning.crescent")
            .font(.callout)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(.defaultReversed)
          
          Picker("", selection: $userTheme) {
            Text("System").tag(Theme.systemDefault)
            Text("Light").tag(Theme.lightMode)
            Text("Dark").tag(Theme.darkMode)
          }
          .onChange(of: userTheme) { _, newValue in
            userTheme = newValue
          }
        }
        
        // 'Log Out' button
        Button("Log Out",systemImage: "rectangle.portrait.and.arrow.right") {
          isPresentedLogOutConfirmation = true
        }
        .foregroundStyle(.red)
        .confirmationDialog("",isPresented: $isPresentedLogOutConfirmation) {
          Button("Log Out",role: .destructive) {
            authViewModel.signOut()
          }
        } message: {
          Text("Are you sure to log out?")
        }
      }
      .listStyle(.insetGrouped)
      
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Image("truck")
            .resizable()
            .frame(width: 32, height: 30)
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          NavigationLink {
            UserPrivateDataPreview()
          } label: {
            Image(systemName: "pencil.and.list.clipboard")
              .imageScale(.large)
              .tint(.defaultOrange)
          }
        }
      }
      .navigationTitle("Profile")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  ProfileScreen()
    .environmentObject(AuthViewModel())
}
