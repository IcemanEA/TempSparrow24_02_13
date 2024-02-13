//
//  PopupViewController.swift
//  TempSparrow24_02_13
//
//  Created by Egor Ledkov on 13.02.2024.
//

import UIKit

class PopupViewController: UIViewController {
	
	private lazy var heightSC: UISegmentedControl = makeHeightSegmentedControl()
	private lazy var closeButton: UIButton = makeCloseButton()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
		closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
		heightSC.addTarget(self, action: #selector(changeHeight), for: .valueChanged)
		view.addSubview(closeButton)
		view.addSubview(heightSC)
		
		layout()
	}
	
	@objc private func changeHeight() {
		let height = heightSC.selectedSegmentIndex == 0 ? 280 : 150
		
		preferredContentSize = CGSize(width: 300, height: height)
	}
	
	@objc private func close() {
		dismiss(animated: true)
	}
}

// MARK: - Layout

private extension PopupViewController {
	
	func layout() {
		NSLayoutConstraint.activate(
			[
				heightSC.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
				heightSC.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
				closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
			]
		)
	}
}


// MARK: - Constructors

private extension PopupViewController {
	
	func makeHeightSegmentedControl() -> UISegmentedControl {
		let segmentedControl = UISegmentedControl(items: ["280pt", "150pt"])
		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
		segmentedControl.selectedSegmentIndex = 0
		return segmentedControl
	}
	
	func makeCloseButton() -> UIButton {
		let button = UIButton(type: .custom)
		
		var imageConfig = UIImage.SymbolConfiguration(hierarchicalColor: .gray)
		imageConfig = imageConfig.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30.0)))
		let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: imageConfig)
		
		button.setImage(image, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		
		return button
	}
}
