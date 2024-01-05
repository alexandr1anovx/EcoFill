//
//  AppearanceChanger.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 29.12.2023.
//

import SwiftUI

struct AppearanceChanger: View {
  var scheme: ColorScheme
  @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
  
  var body: some View {
    VStack(spacing:15) {
      Label("Select Color Theme", systemImage: "moon.fill")
        .font(.headline)
        .imageScale(.large)
      
      HStack(spacing:20) {
        ForEach(Theme.allCases, id: \.rawValue) { theme in
          Button {
            userTheme = theme
          } label: {
            if userTheme == theme {
              RoundedRectangle(cornerRadius:20)
                .fill(.customDarkBlue)
                .frame(width: 100, height: 50)
                .overlay {
                  Text(theme.rawValue)
                    .foregroundStyle(.white).bold()
                }
            } else {
              RoundedRectangle(cornerRadius:10)
                .fill(Color.customDarkBlue)
                .opacity(0.4)
                .frame(width: 100, height: 50)
                .overlay {
                  Text(theme.rawValue)
                    .foregroundStyle(.white).bold()
                }
            }
          }
        }
      }
      .padding(15)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .frame(height: 180)
    .background(.defaultBackground)
    .clipShape(.rect(cornerRadius: 20))
    .padding(.horizontal,10)
    .environment(\.colorScheme, scheme)
  }
}

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

#Preview {
  AppearanceChanger(scheme: .light)
}
