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
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()
  
  var body: some View {
    NavigationStack {
      if let currentUser = authenticationVM.currentUser {
        VStack(alignment: .leading, spacing:10) {
          HStack {
            Text("Full name:")
              .font(.footnote)
              .fontWeight(.semibold)
              .foregroundStyle(.gray)
            
            Text(currentUser.fullName)
              .font(.callout)
              .fontWeight(.medium)
              .foregroundStyle(.defaultReversed)
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
        .padding(.horizontal)
        .padding(.top,40)
        
        Image(uiImage: generateQRCode(from: "\(currentUser.fullName)\n\(currentUser.email)"))
          .resizable()
          .interpolation(.none)
          .scaledToFit()
          .frame(width:170, height:170)
          .padding(.top,20)
        
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
    .environmentObject(AuthenticationViewModel())
}
