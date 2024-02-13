//
//  ViewController.swift
//  TempSparrow24_02_13
//
//  Created by Egor Ledkov on 13.02.2024.
//

import UIKit

class ViewController: UIViewController {
	
	private lazy var presentButton: UIButton = {
		let button = UIButton(type: .system)
		
		button.setTitle("Present", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
		button.translatesAutoresizingMaskIntoConstraints = false
		
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
		presentButton.addTarget(self, action: #selector(openPopController), for: .touchUpInside)
		view.addSubview(presentButton)
		
		layout()
	}
	
	@objc private func openPopController() {
		let popupVC = PopupViewController()
		
		popupVC.modalPresentationStyle = .popover
		popupVC.preferredContentSize = CGSize(width: 300, height: 280)
		popupVC.popoverPresentationController?.sourceView = self.view
		popupVC.popoverPresentationController?.sourceRect = CGRect(
			origin: CGPoint(
				x: self.presentButton.frame.midX,
				y: self.presentButton.frame.maxY
			),
			size: .zero
		)
		popupVC.popoverPresentationController?.permittedArrowDirections = [.up]
		popupVC.popoverPresentationController?.delegate = self
		
		present(popupVC, animated: true)
	}
}

// MARK: - Layout

private extension ViewController {
	
	private func layout() {
		NSLayoutConstraint.activate(
			[
				presentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
				presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
			]
		)
	}
}

// MARK: - UIPopoverPresentationControllerDelegate

extension ViewController: UIPopoverPresentationControllerDelegate {
	
	func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
		.none
	}
}
