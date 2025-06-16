//
//  DeveloperScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 13.06.2025.
//

import SwiftUI

struct AboutTheDeveloperScreen: View {
  
  private let githubURL = URL(string: "https://github.com/alexandr1anov")
  private let linkedinURL = URL(string: "https://linkedin.com/in/alexandr1anov")
  private let appleURL = URL(string: "https://www.apple.com")!
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack(spacing: 15) {
        Text("Alexander Andrianov, **iOS Engineer**")
        HStack(spacing: 10) {
          Link(destination: githubURL ?? appleURL) {
            Text("GitHub")
              .underline() // does not work on the HStack
          }
          Link(destination: linkedinURL ?? appleURL) {
            Text("LinkedIn")
              .underline()
          }
        }
        .font(.headline)
        .foregroundStyle(.blue)
      }
    }
  }
}

#Preview {
  AboutTheDeveloperScreen()
}
