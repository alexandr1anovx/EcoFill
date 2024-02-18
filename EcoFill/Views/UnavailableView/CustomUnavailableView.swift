//
//  CustomUnavailableView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 12.02.2024.
//

import SwiftUI

struct CustomUnavailableView: View {
  var body: some View {
    ContentUnavailableView("An error occurred.", 
                           systemImage: "text.badge.xmark",
                           description:
                            Text("Please, check your internet connection."))
  }
}

#Preview {
  CustomUnavailableView()
}
