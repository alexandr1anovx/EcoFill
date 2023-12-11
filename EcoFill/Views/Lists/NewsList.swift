//
//  NewsList.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 10.12.2023.
//

import SwiftUI

struct NewsList: View {
  var body: some View {
    NavigationStack {
      if testNews.isEmpty {
        ContentUnavailableView("The list of news is empty.",
                               systemImage: "newspaper",
                               description: Text("Please, check your internet connection."))
      } else {
        List(testNews){ article in
          NewsCell(article: article)
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(20)
        .navigationTitle("Новини")
        .navigationBarTitleDisplayMode(.inline)
      }
    }
  }
}

#Preview {
  NewsList()
}
