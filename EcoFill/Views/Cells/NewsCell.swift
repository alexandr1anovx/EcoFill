//
//  NewsCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 10.12.2023.
//

import SwiftUI

struct NewsCell: View {
  var article: News
  
  var body: some View {
    HStack {
      Text(article.title)
        .font(.callout)
        .fontWeight(.medium)
        .fontDesign(.rounded)
        .multilineTextAlignment(.leading)
      
      Spacer()
      
      Link("Читати", destination: URL(string: "https://www.apple.com")!)
    }
  }
}

#Preview {
  NewsCell(article: testNews[0])
}
