//
//  ViewController.swift
//  iOS-seminar-1
//
//  Created by Egor Kolobaev on 15.03.2025.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Variables

    @IBOutlet var views: [UIView]!
    @IBOutlet weak var button: UIButton!

    // MARK: - Internal functions
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    @IBAction func buttonWasPressed(_ sender: UIButton) {
        updateViews()
    }

    // MARK: - Private functions

    @MainActor private func updateViews() {
        guard let button else {
            return
        }
        button.isEnabled = false
        UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
            guard let views = self?.views else { return }
            UIColor.getUniqueColors(count: views.count).enumerated().forEach { (index, color) in
                guard index < views.count else {
                    return
                }
                views[index].backgroundColor = color
                views[index].layer.cornerRadius = .random(
                    in: Constants.minCornerRadius...Constants.maxCornerRadius
                )
            }
        } completion: { _ in
            button.isEnabled = true
        }
    }
}

private enum Constants {
    static let minCornerRadius: CGFloat = 0
    static let maxCornerRadius: CGFloat = 25

    static let animationDuration: TimeInterval = 3
}
