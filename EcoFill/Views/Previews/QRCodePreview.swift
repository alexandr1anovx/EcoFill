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
      if let user = authenticationVM.currentUser {
        VStack(alignment: .center, spacing: 20) {
          HStack {
            VStack(alignment: .leading, spacing: 5) {
              InformationField(imageName: "initials", title: "Full name:", content: user.fullName)
              InformationField(imageName: "book", title: "Email:", content: user.email)
            }
            
            Spacer()
          }

          Image(uiImage: generateQRCode(from: "\("Alexander")\n\("sasha8811andrianov@gmail.com")"))
            .resizable()
            .interpolation(.none)
            .frame(width: 150, height: 150)
        }
        .padding(.bottom, 40)
        .padding(.horizontal)
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            DismissXButton()
          }
        }
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
