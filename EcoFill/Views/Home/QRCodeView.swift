import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    @EnvironmentObject var userVM: UserViewModel
    
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack(alignment: .center) {
            if let user = userVM.currentUser {
                Image(uiImage: generateQRCode(from: user.initials))
                    .resizable()
                    .interpolation(.none)
                    .frame(width: 180, height: 180)
            } else {
                ProgressView("Loading user data...")
            }
        }
        .padding(.horizontal)
    }
}

private extension QRCodeView {
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return UIImage()
    }
}
