//
//  QRCodeViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 27.06.2025.
//

import Foundation
import UIKit

@MainActor
final class QRCodeViewModel: ObservableObject {
  @Published var qrCodeImage: UIImage?
  @Published var scannedCode: String?
  @Published var errorMessage: String?
  @Published var isShownAlert: Bool = false
  
  let sessionManager: SessionManager
  
  init(sessionManager: SessionManager) {
    self.sessionManager = sessionManager
  }
  
  func openAppSettings() {
    guard let appSettings = URL(string: UIApplication.openSettingsURLString) else {
      return
    }
    if UIApplication.shared.canOpenURL(appSettings) {
      UIApplication.shared.open(appSettings)
    }
  }
  
  func generateQRCodeImage() {
    guard let user = sessionManager.currentUser else {
      print("⚠️ QRCodeViewModel: Fail to retrieve user!")
      return
    }
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    filter.message = Data(user.fullName.utf8)
    
    if let outputImage = filter.outputImage,
       let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
      qrCodeImage = UIImage(cgImage: cgImage)
    } else {
      errorMessage = "Error generating QR code."
    }
  }
}
