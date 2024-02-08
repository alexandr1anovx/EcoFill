//
//  UserPrivateDataPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

@MainActor
struct UserPrivateDataPreview: View {
  // MARK: - Properties
  @EnvironmentObject var authViewModel: AuthViewModel
  @FocusState private var focusedTextField: RegistrationFormTextField?
  
  @State private var fullName: String = ""
  @State private var email: String = ""
  @State private var isPresentedDeletion: Bool = false
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Full Name", text: $fullName)
            .focused($focusedTextField, equals: .fullName)
            .onSubmit { focusedTextField = .email }
            .submitLabel(.next)
            .textContentType(.name)
          
          TextField("Email", text: $email)
            .focused($focusedTextField, equals: .email)
            .onSubmit { focusedTextField = nil }
            .submitLabel(.done)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
        } header: {
          Text("Personal data")
        }
        
        Section {
          Button("Edit", systemImage: "pencil") {
            focusedTextField = .fullName
          }
          .foregroundStyle(.red)
          
          Button("Save changes", systemImage: "checkmark.circle.fill") {
            
          }
        }
        
        Button("Delete account",
               systemImage: "xmark.circle.fill",
               role: .destructive,
               action: {
          isPresentedDeletion.toggle()
        })
        .foregroundStyle(.red)
        .confirmationDialog("Are you sure?",
                            isPresented: $isPresentedDeletion) {
          Button("Delete", role: .destructive) {
            authViewModel.deleteAccount()
          }
        } message: {
          Text("All your data will be deleted.")
        }
      }
      
      /// Show an alert, the type of which depends of the Form error.
//      .alert(item: $authViewModel.alertItem) { alertItem in
//        Alert(title: alertItem.title,
//              message: alertItem.message,
//              dismissButton: alertItem.dismissButton)
//      }
    }
  }
}

#Preview {
  UserPrivateDataPreview()
    .environmentObject(AuthViewModel())
}

//extension
