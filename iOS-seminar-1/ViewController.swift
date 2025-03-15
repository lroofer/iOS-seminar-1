//
//  ViewController.swift
//  iOS-seminar-1
//
//  Created by Egor Kolobaev on 15.03.2025.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var views: [UIView]!
  @IBOutlet weak var button: UIButton!

  private var updatingInterfaceTask: TaskGroup<Void>?

  override func viewDidLoad() {
    super.viewDidLoad()

    updateViews()
  }

  @IBAction func buttonWasPressed(_ sender: UIButton) {
    updateViews()
  }

  @MainActor private func updateViews() {
    guard let button else {
      return
    }
    button.isEnabled = false
    UIView.animate(withDuration: .animationDuration) { [weak self] in
      guard let views = self?.views else { return }
      UIColor.getUniqueColors(count: views.count).enumerated().forEach { (index, color) in
        guard index < views.count else {
          return
        }
        views[index].backgroundColor = color
        views[index].layer.cornerRadius = .random(
          in: CGFloat.minCornerRadius...CGFloat.maxCornerRadius
        )
      }
    } completion: { _ in
      button.isEnabled = true
    }
  }
}

private extension CGFloat {
  static let minCornerRadius: Self = 0
  static let maxCornerRadius: Self = 25
}

private extension TimeInterval {
  static let animationDuration: Self = 3
}
