//
//  ViewController.swift
//  Example
//
//  Created by Omar Albeik on 2/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit
import WeekdaysSegmentedControl

class ViewController: UIViewController {

	@IBOutlet weak var control: WeekdaysSegmentedControl!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// customize the control
		control.selectedColor = .blue
		control.deselectedColor = .gray
		control.cornerRadius = 5
		control.borderWidth = 2
		control.borderColor = .blue
		control.font = .systemFont(ofSize: 15)
		control.setButtonsTitleColor(.black, for: .normal)
		control.setButtonsTitleColor(.white, for: .selected)
		control.setButtonsTitleColor(.blue, for: .highlighted)
		
		// optionally, set initial values
		control.selectedDays = [1, 3]

		// optionally, set delegate to listen to button events.
		control.delegate = self
		
	}

}

extension ViewController: WeekdaysSegmentedControlDelegate {
	
	func weekDaysSegmentedControl(_ control: WeekdaysSegmentedControl, didSelectDay day: Int) {
		print("did select day with index: \(day)")
	}
	
	func weekDaysSegmentedControl(_ control: WeekdaysSegmentedControl, didDeselectDay day: Int) {
		print("did deselect day with index: \(day)")
	}
}
