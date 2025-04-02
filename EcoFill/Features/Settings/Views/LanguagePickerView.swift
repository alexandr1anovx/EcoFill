//
//  LanguageChanger.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 28.03.2025.
//

import SwiftUI

enum Language: String, CaseIterable, Identifiable {
  case english
  case ukrainian
  
  var id: Self { self }
  
  var title: LocalizedStringKey {
    switch self {
    case .english: "language_english"
    case .ukrainian: "language_ukrainian"
    }
  }
}

struct LanguagePickerView: View {
  @State private var selectedLanguage: Language = .english
  
  var body: some View {
    HStack {
      HStack(spacing: 15) {
        Image(systemName: "globe")
          .foregroundStyle(.pink)
        Text("language_label")
          .font(.subheadline)
          .fontWeight(.medium)
      }
      Picker("", selection: $selectedLanguage) {
        ForEach(Language.allCases) { language in
          Text(language.title)
        }
      }.tint(.primaryLabel)
    }
  }
}

