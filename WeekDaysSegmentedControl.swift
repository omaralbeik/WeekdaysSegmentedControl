//
//  WeekDaysSegmentedControl.swift
//  WeekDaysSegmentedControlExample
//
//  Created by Omar Albeik on 5/11/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

@objc protocol WeekDaysSegmentedControlDelegate {
  ///Set when segment changes
  optional func segmentsDidChange(control: WeekDaysSegmentedControl, selectedIndexes: [Int])
}

private extension String {
  
  func replace(index: Int, newChar: Character) -> String {
    var chars = Array(self.characters) // gets an array of characters
    chars[index] = newChar
    let modifiedString = String(chars)
    return modifiedString
  }
  
}

class WeekDaysSegmentedControl: UIView {
  
  private var buttonTitles = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
  var borderColor = UIColor.blueColor()
  var textColor = UIColor.darkGrayColor()
  var font = UIFont.systemFontOfSize(13)
  private var indexes: [Int] = []
  
  var delegate: WeekDaysSegmentedControlDelegate?
  
  var selectedIndexes: [Int] {
    get {
      return indexes.sort()
    }
    set {
      indexes = newValue
    }
  }
  
  var daysString: String {
    
    get {
      
      var days = "0000000"
      
      guard selectedIndexes.count > 0 else {
        return days
      }
      
      for index in selectedIndexes {
        days = days.replace(index, newChar: "1")
      }
      return days
    }
    
    set {
      
      guard newValue.characters.count == 7 else {
        print("\(newValue) is not a valid days string")
        return
      }
      
      for (index, element) in newValue.characters.enumerate() {
        if element == "1" {
          indexes.append(index)
        }
      }
      
    }
    
    
    
  }
  
  override func layoutSubviews() {
    
    self.layer.cornerRadius = 2
    self.layer.borderWidth = 1
    self.layer.borderColor = self.borderColor.CGColor
    self.layer.masksToBounds = true
    
    if self.subviews.count <= 0 {
      
      for (index, title) in buttonTitles.enumerate() {
        let buttonWidth = self.frame.width / CGFloat(buttonTitles.count)
        let buttonHeight = self.frame.height
        
        let button = UIButton(frame: CGRectMake(CGFloat(index) * buttonWidth, 0, buttonWidth, buttonHeight))
        
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(self.textColor, forState: .Normal)
        button.titleLabel?.font = self.font
        button.addTarget(self, action: #selector(self.changeSegment(_:)), forControlEvents: .TouchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = self.borderColor.CGColor
        button.tag = index
        
        for item in indexes {
          if item == index {
            button.backgroundColor = borderColor
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
          }
        }
        self.addSubview(button)
      }
    }
    
  }
  
  func changeSegment(sender: UIButton) {
    
    print(sender.tag)
    
    
    if sender.backgroundColor == borderColor {
      sender.backgroundColor = UIColor.clearColor()
      sender.setTitleColor(textColor, forState: .Normal)
      
      for (index, element) in indexes.enumerate() {
        if element == sender.tag {
          indexes.removeAtIndex(index)
        }
      }
      
    } else {
      sender.backgroundColor = borderColor
      sender.setTitleColor(UIColor.whiteColor(), forState: .Normal)
      self.indexes.append(sender.tag)
    }
    
    print(daysString)
    
    delegate?.segmentsDidChange?(self, selectedIndexes: selectedIndexes)
  }
  
}
