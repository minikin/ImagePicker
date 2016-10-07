//
//  OverlayView.swift
//  checkUIPicker
//
//  Created by IoT on 07/10/16.
//  Copyright © 2016 Sasha Prokhorenk. All rights reserved.
//

import UIKit

/// Custom view that displays when a user adds a Car to the Garage (Saves it locally)
class OverlayView: UIView {

	// Our custom view from the XIB file
	var view: UIView!

	/**
		Initialiser method

		- parameter frame: frame to use for the view
	*/
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	/**
		Initialiser method

		- parameter aDecoder: aDecoder
	*/
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupView()
	}

	/**
	Loads a view instance from the xib file

	- returns: loaded view
	*/
	func loadViewFromXibFile() -> UIView {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: "OverlayView", bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
		return view
	}


	/**
		Sets up the view by loading it from the xib file and setting its frame
	*/
	func setupView() {
		view = loadViewFromXibFile()
		view.frame = bounds
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)

		self.translatesAutoresizingMaskIntoConstraints = false

		view.layer.cornerRadius = 4.0
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 0.2
		view.layer.shadowRadius = 4.0
//		view.layer.shadowOffset = CGSizeMake(0.0, 8.0)

	}



	/**
	Displays the overlayView on the passed in view

	- parameter onView: the view that will display the overlayView
	*/
	func displayView(onView: UIView) {
		self.alpha = 0.0
		onView.addSubview(self)

		onView.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: onView, attribute: .centerY, multiplier: 1.0, constant: -80.0)) // move it a bit upwards
		onView.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: onView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
		onView.needsUpdateConstraints()

		// display the view
		transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//		UIView.animate(withDuration: 0.3, animations: { () -> Void in
//			self.alpha = 1.0
//			self.transform = CGAffineTransformIdentity
//		}) { (finished) -> Void in
//			// When finished wait 1.5 seconds, than hide it
//			let delayTime = DispatchTime.now(DispatchTime.now, Int64(1.5 * Double(NSEC_PER_SEC)))
//			dispatch_after(delayTime, DispatchQueue.main) {
//				self.hideView()
//			}
//		}
	}

	/**
	Updates constraints for the view. Specifies the height and width for the view
	*/
	override func updateConstraints() {
		super.updateConstraints()

		addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 170.0))
		addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0))
		addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
		addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
		addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
		addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
	}

	/**
	Hides the view with animation
	*/
	private func hideView() {
		UIView.animate(withDuration: 0.3, animations: { () -> Void in
			self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
		}) { (finished) -> Void in
			self.removeFromSuperview()
		}
	}

}
