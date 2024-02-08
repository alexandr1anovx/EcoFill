//
//  AppearanceChanger.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 29.12.2023.
//

import SwiftUI

enum Theme: String, CaseIterable {
  case systemDefault = "System"
  case lightMode = "Light"
  case darkMode = "Dark"
  
  var colorScheme: ColorScheme? {
    switch self {
    case .systemDefault: return nil
    case .lightMode: return .light
    case .darkMode: return .dark
    }
  }
}

struct AppearanceChangerPreview: View {
  // MARK: - Properties
  var scheme: ColorScheme
  @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
  
  // MARK: - body
  var body: some View {
    VStack(spacing:25) {
      HStack {
        switch userTheme {
        case .systemDefault, .lightMode:
          Image(systemName: "sun.max.fill")
        case .darkMode:
          Image(systemName: "moon.circle.fill")
        }
      }
      .symbolRenderingMode(.multicolor)
      .imageScale(.large)
      
      
      HStack(spacing:20) {
        ForEach(Theme.allCases, id: \.rawValue) { theme in
          Button {
            userTheme = theme
          } label: {
            RoundedRectangle(cornerRadius: userTheme == theme ? 15 : 10)
              .fill(.defaultBlack)
              .frame(width: 80, height: 45)
              .opacity(userTheme == theme ? 1.0 : 0.5)
              .overlay {
                Text(theme.rawValue)
                  .font(.callout)
                  .foregroundStyle(.white)
                  .fontWeight(.medium)
              }
          }
        }
      }
    }
    .environment(\.colorScheme, scheme)
  }
}

#Preview {
  AppearanceChangerPreview(scheme: .light)
}
