import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeScreen: View {
  
  private let context = CIContext()
  private let filter = CIFilter.qrCodeGenerator()
  @EnvironmentObject var userVM: UserViewModel
  
  var body: some View {
    ZStack {
      Color.primaryBackground.ignoresSafeArea(.all)
      VStack {
        if let user = userVM.currentUser {
          Image(uiImage: generateQRCode(from: user.initials))
            .resizable()
            .interpolation(.none)
            .frame(width: 230, height: 230)
        } else {
          ProgressView("Loading user data...")
        }
      }
    }
  }
  
  private func generateQRCode(from string: String) -> UIImage {
    filter.message = Data(string.utf8)
    if let outputImage = filter.outputImage,
       let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
      return UIImage(cgImage: cgImage)
    }
    return UIImage()
  }
}
