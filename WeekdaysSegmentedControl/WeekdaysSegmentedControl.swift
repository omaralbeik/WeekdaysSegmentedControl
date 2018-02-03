//
//  WeekdaysSegmentedControl.swift
//  WeekdaysSegmentedControl
//
//  Created by Omar Albeik on 2/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

/// WeekdaysSegmentedControl delegate.
public protocol WeekdaysSegmentedControlDelegate: class {
	
	/// Called when a daySegmentedControl selects a day.
	///
	/// - Parameters:
	///   - control: WeekdaysSegmentedControl.
	///   - day: selected day.
	func weekDaysSegmentedControl(_ control: WeekdaysSegmentedControl, didSelectDay day: Int)
	
	/// Called when a daySegmentedControl deselects a day.
	///
	/// - Parameters:
	///   - control: WeekdaysSegmentedControl.
	///   - day: deselected day.
	func weekDaysSegmentedControl(_ control: WeekdaysSegmentedControl, didDeselectDay day: Int)
}

public extension WeekdaysSegmentedControlDelegate {
	func weekDaysSegmentedControl(_ control: WeekdaysSegmentedControl, didSelectDay day: Int) {}
	func weekDaysSegmentedControl(_ control: WeekdaysSegmentedControl, didDeselectDay day: Int) {}
}

@IBDesignable
public class WeekdaysSegmentedControl: UIView {
	
	/// WeekdaysSegmentedControl delegate.
	public weak var delegate: WeekdaysSegmentedControlDelegate?
	
	/// Day names returned from current Calendar.
	public let dayNames = Calendar.current.shortWeekdaySymbols
	
	/// Weekday buttons label font.
	public var font: UIFont! {
		didSet {
			buttons.forEach { $0.titleLabel?.font = font }
		}
	}
	
	/// Selected days background color.
	public var selectedColor: UIColor? {
		didSet {
			buttons.forEach { $0.selectedColor = selectedColor }
		}
	}
	
	/// Deselected days background color.
	public var deselectedColor: UIColor? {
		didSet {
			buttons.forEach { $0.deselectedColor = deselectedColor }
		}
	}
	
	/// Border color.
	public var borderColor: UIColor? {
		didSet {
			containerView.layer.borderColor = borderColor?.cgColor
		}
	}
	
	/// Border width.
	public var borderWidth: CGFloat! {
		didSet {
			containerView.layer.borderWidth = borderWidth
		}
	}
	
	/// Corner radius.
	public var cornerRadius: CGFloat! {
		didSet {
			containerView.layer.cornerRadius = cornerRadius
		}
	}
	
	public override var backgroundColor: UIColor? {
		didSet {
			containerView.backgroundColor = backgroundColor
			stackView.backgroundColor = backgroundColor
		}
	}
	
	/// Selected days array.
	public var selectedDays: [Int] = [] {
		didSet {
			stackView.arrangedSubviews.forEach { ($0 as! WeekdayButton).isSelected = selectedDays.contains($0.tag) }
		}
	}
	
	private let containerView: UIView = {
		let view = UIView()
		view.clipsToBounds = true
		return view
	}()
	
	private let stackView: UIStackView = {
		let view = UIStackView()
		view.axis = .horizontal
		view.distribution = .fillEqually
		view.alignment = .fill
		view.spacing = 0.5
		return view
	}()
	
	private var buttons: [WeekdayButton] {
		return stackView.arrangedSubviews as! [WeekdayButton]
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		
		setViews()
		layoutViews()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		setViews()
		layoutViews()
	}
	
	/// Set title color for weekday buttons.
	///
	/// - Parameters:
	///   - color: Title color.
	///   - state: State to set its color.
	public func setButtonsTitleColor(_ color: UIColor?, for state: UIControlState) {
		buttons.forEach { $0.setTitleColor(color, for: state) }
	}
}

// MARK: - Helpers
fileprivate extension WeekdaysSegmentedControl {
	
	func button(forDayName name: String) -> WeekdayButton {
		let button = WeekdayButton()
		button.setTitle(name.uppercased(), for: .normal)
		button.addTarget(self, action: #selector(didTapDayButton(_:)), for: .touchUpInside)
		return button
	}
	
	@objc
	func didTapDayButton(_ sender: WeekdayButton) {
		if sender.isSelected {
			selectedDays = selectedDays.filter { $0 != sender.tag }
			delegate?.weekDaysSegmentedControl(self, didDeselectDay: sender.tag)
		} else {
			var days = selectedDays
			days.append(sender.tag)
			selectedDays = days.sorted()
			delegate?.weekDaysSegmentedControl(self, didSelectDay: sender.tag)
		}
	}
}

// MARK: - Setup
private extension WeekdaysSegmentedControl {
	
	func setViews() {
		dayNames.enumerated().forEach { (index, name) in
			let button = self.button(forDayName: name)
			button.tag = index
			stackView.addArrangedSubview(button)
		}
		
		buttons.forEach { stackView.addArrangedSubview($0) }
		containerView.addSubview(stackView)
		addSubview(containerView)
		
		backgroundColor = .clear
		borderColor = .black
		borderWidth = 1.5
		cornerRadius = 8.0
		font = .systemFont(ofSize: 14.0, weight: .semibold)
		
		selectedColor = .blue
		deselectedColor = .white
		
		buttons.forEach { $0.isSelected = false }
		
		setButtonsTitleColor(.black, for: .normal)
		setButtonsTitleColor(.white, for: .selected)
	}
	
	func layoutViews() {
		containerView.fillSuperview()
		stackView.fillSuperview()
	}
}

/// WeekdayButton
private class WeekdayButton: UIButton {
	
	var selectedColor: UIColor?
	var deselectedColor: UIColor?
	
	override var isSelected: Bool {
		didSet {
			backgroundColor = isSelected ? selectedColor : deselectedColor
		}
	}
	
}

// MARK: - Autolayout helpers
private extension UIView {
	
	func fillSuperview() {
		guard let aSuperView = superview else { return }
		translatesAutoresizingMaskIntoConstraints = false
		
		topAnchor.constraint(equalTo: aSuperView.topAnchor).isActive = true
		trailingAnchor.constraint(equalTo: aSuperView.trailingAnchor).isActive = true
		leadingAnchor.constraint(equalTo: aSuperView.leadingAnchor).isActive = true
		bottomAnchor.constraint(equalTo: aSuperView.bottomAnchor).isActive = true
	}
	
}
