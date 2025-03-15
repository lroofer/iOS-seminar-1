//
//  Color+Random.swift
//  iOS-seminar-1
//
//  Created by Egor Kolobaev on 15.03.2025.
//

import UIKit

extension UIColor {
  static var random: UIColor {
    randomHEX.color
  }

  static var randomHEX: String {
    let letters = "0123456789ABCDEF"
    var color = "#"

    for _ in 0..<6 {
      color += String(letters.randomElement()!)
    }

    return color
  }

  static func getUniqueColors(count: Int) -> [UIColor] {
    var set = Set<UIColor>()

    while set.count < count {
      set.insert(.random)
    }

    return set.shuffled()
  }
}

private extension String {
  var color: UIColor {
    let hexSanitized = self
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .replacingOccurrences(of: "#", with: "")

    var rgb: UInt64 = 0

    guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
      return .black
    }

    let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
    let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
    let b = CGFloat(rgb & 0x0000FF) / 255.0

    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
  }
}
