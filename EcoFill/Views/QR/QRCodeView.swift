//
//  QRCodePreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
  
  // MARK: - properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()
  
  var body: some View {
    NavigationStack {
      if let user = authenticationVM.currentUser {
        VStack(spacing: 20) {
          VStack(alignment: .leading, spacing: 10) {
            InformationRow(
              img: .initials,
              text: "Initials:",
              content: user.fullName)
            
            InformationRow(
              img: .mail,
              text: "Email:",
              content: user.email)
          }
          
          Image(uiImage: generateQRCode(from: "\(user.fullName)\n\(user.email)"))
            .resizable()
            .interpolation(.none)
            .frame(width: 150, height: 150)
          
        }
        .padding(.bottom, 40)
        .padding(.horizontal)
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            DismissXBtn()
              .foregroundStyle(.red)
          }
        }
      }
    }
  }
  
  private func generateQRCode(from string: String) -> UIImage {
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
  QRCodeView()
    .environmentObject(AuthenticationViewModel())
}


