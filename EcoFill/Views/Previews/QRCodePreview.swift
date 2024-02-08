//
//  QRCodePreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodePreview: View {
  // MARK: - Properties
  //  @Binding var isShowingQRCodePreview: Bool
  
  @State private var name: String = ""
  @State private var emailAddress: String = ""
  @EnvironmentObject var authViewModel: AuthViewModel
  
  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      if let currentUser = authViewModel.currentUser {
        VStack(alignment: .leading,spacing:15) {
          HStack {
            Text("Full name:")
              .foregroundStyle(.gray)
              .font(.footnote)
              .fontWeight(.semibold)
            
            Text(currentUser.fullName)
              .foregroundStyle(.defaultReversed)
              .font(.callout)
              .fontWeight(.semibold)
          }
          
          Divider()
          
          HStack {
            Text("Email address:")
              .foregroundStyle(.gray)
              .font(.footnote)
              .fontWeight(.medium)
            Text(currentUser.email)
              .foregroundStyle(.defaultReversed)
              .font(.callout)
              .fontWeight(.medium)
          }
        }
        .padding()
        .navigationTitle("QR Code")
        .navigationBarTitleDisplayMode(.inline)
        
        Image(uiImage: generateQRCode(from: "\(currentUser.fullName)\n\(currentUser.email)"))
          .resizable()
          .interpolation(.none)
          .scaledToFit()
          .frame(width: 170, height: 170)
          .padding(.top,15)
        
        Spacer()
      }
    }
  }
  
  func generateQRCode(from string: String) -> UIImage {
    filter.message = Data(string.utf8)
    if let outputImage = filter.outputImage {
      if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
        return UIImage(cgImage: cgImage)
      }
    }
    return UIImage(systemName: "xmark.circle") ?? UIImage()
  }
}

#Preview {
  QRCodePreview()
    .environmentObject(AuthViewModel())
}
