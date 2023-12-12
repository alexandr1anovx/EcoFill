//
//  Service.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.
//

import Foundation

struct Service: Identifiable {
  let id = UUID()
  let title: String
  let description: String
  let image: String
}

let services: [Service] = [
  Service(title: "Наші продукти",
          description: "Дізнайтесь ціну та деталі.",
          image: "fuelpump"),
  
  Service(title: "Новини",
          description: "Будьте в курсі останніх подій.",
          image: "newspaper"),
  
  Service(title: "Залишити відгук",
          description: "Надішліть відгук, щоб поліпшити наш сервіс.",
          image: "message.badge")
]
