//
//  News.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 10.12.2023.
//

import Foundation

struct News: Identifiable {
  let id = UUID()
  let title: String
}

let testNews: [News] = [
  News(title: "SOCAR шукатиме ізраїльський газ разом з British Petroleum"),
  News(title: "SOCAR оголошує збір коштів на протези для постраждалих українців"),
  News(title: "Укрнафта і SOCAR розпочали співпрацю у сфері паливних карток")
]
