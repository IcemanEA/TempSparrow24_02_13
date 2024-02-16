//
//  SparrowViewController.swift
//  TempSparrow24_02_13
//
//  Created by Egor Ledkov on 16.02.2024.
//

import UIKit

class SparrowViewController: UIViewController {
	
	private let button = UIButton()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
		button.setTitle("Present", for: .normal)
		button.setTitleColor(.tintColor, for: .normal)
		button.addAction(UIAction(handler: { _ in
			let popup = PopoverNavigationController(
				root: ChildController(),
				size: CGSize(width: 300, height: 280),
				sourceView: self.button,
				sourceRect: self.button.bounds,
				direction: .up
			)
			
			self.present(popup, animated: true)
		}), for: .touchUpInside)
		view.addSubview(button)
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		button.sizeToFit()
		button.center.x = view.frame.width / 2
		button.frame.origin.y = view.layoutMargins.top + 24
	}
}

class ChildController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let segment = UISegmentedControl(items: ["280pt", "150pt"])
		segment.addAction(UIAction(handler: { _ in
			self.navigationController?.preferredContentSize = CGSize(
				width: 300,
				height: segment.selectedSegmentIndex == 0 ? 280 : 150
			)
		}), for: .valueChanged)
		
		segment.selectedSegmentIndex = .zero
		navigationItem.titleView = segment
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .close, primaryAction: UIAction(handler: { _ in
			self.dismiss(animated: true)
		}))
	}
}

class PopoverNavigationController: UINavigationController, UIPopoverPresentationControllerDelegate {
	
	init(
		root: UIViewController,
		size: CGSize,
		sourceView: UIView,
		sourceRect: CGRect,
		direction: UIPopoverArrowDirection
	) {
		super.init(rootViewController: root)
		
		modalPresentationStyle = .popover
		preferredContentSize = size
		
		popoverPresentationController?.permittedArrowDirections = [direction]
		popoverPresentationController?.sourceView = sourceView
		popoverPresentationController?.sourceRect = sourceRect
		
		popoverPresentationController?.delegate = self
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .secondarySystemBackground
	}
	
	func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
		.none
	}
}
