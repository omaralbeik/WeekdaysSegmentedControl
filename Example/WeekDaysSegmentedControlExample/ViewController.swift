//
//  ViewController.swift
//  WeekDaysSegmentedControlExample
//
//  Created by Omar Albeik on 5/11/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var weekDaysSegmentedControl: WeekDaysSegmentedControl!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.weekDaysSegmentedControl.daysString = "0101010"
    
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

