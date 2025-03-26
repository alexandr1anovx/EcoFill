//
//  QRScannerView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 19.03.2025.
//

import SwiftUI
import AVFoundation

struct QRScannerView: UIViewControllerRepresentable {
  class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    var parent: QRScannerView
    
    init(parent: QRScannerView) {
      self.parent = parent
    }
    
    func metadataOutput(
      _ output: AVCaptureMetadataOutput,
      didOutput metadataObjects: [AVMetadataObject],
      from connection: AVCaptureConnection
    ) {
      if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
         let scannedString = metadataObject.stringValue {
        DispatchQueue.main.async {
          self.parent.scannedCode = scannedString
        }
      }
    }
  }
  
  @Binding var scannedCode: String?
  @Binding var errorMessage: String?
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  func makeUIViewController(context: Context) -> UIViewController {
    let viewController = UIViewController()
    let captureSession = AVCaptureSession()
    
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized:
      break
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { granted in
        if !granted {
          DispatchQueue.main.async {
            self.errorMessage = "Access to the camera is denied. Allow use of the camera in the settings."
          }
        }
      }
    default:
      DispatchQueue.main.async {
        self.errorMessage = "There is no access to the camera. Allow it in the device settings."
      }
      return viewController
    }
    
    guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
      DispatchQueue.main.async {
        self.errorMessage = "No camera found."
      }
      return viewController
    }
    
    guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else {
      DispatchQueue.main.async {
        self.errorMessage = "Error when setting up the camera."
      }
      return viewController
    }
    
    if captureSession.canAddInput(videoInput) {
      captureSession.addInput(videoInput)
    } else {
      DispatchQueue.main.async {
        self.errorMessage = "Failed to add a camera to the session."
      }
      return viewController
    }
    
    let metadataOutput = AVCaptureMetadataOutput()
    if captureSession.canAddOutput(metadataOutput) {
      captureSession.addOutput(metadataOutput)
      metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
      metadataOutput.metadataObjectTypes = [.qr]
    } else {
      DispatchQueue.main.async {
        self.errorMessage = "Error when adding a QR code scanner."
      }
      return viewController
    }
    
    let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = viewController.view.layer.bounds
    previewLayer.videoGravity = .resizeAspectFill
    viewController.view.layer.addSublayer(previewLayer)
    
    captureSession.startRunning()
    
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
