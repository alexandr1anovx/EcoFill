//
//  HotlineNumberCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 28.02.2024.
//

import SwiftUI

struct HotlineNumberCell: View {
  var phoneNumber: String
  
  var body: some View {
    Button(phoneNumber, systemImage: "phone") {
      // make phone call
    }
    .buttonStyle(CustomButtonModifier(pouring: .accent))
  }
}

#Preview {
  HotlineNumberCell(phoneNumber: "(050)-660-02-30")
}
