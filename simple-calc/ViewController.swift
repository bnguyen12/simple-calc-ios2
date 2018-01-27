//
//  ViewController.swift
//  simple-calc
//
//  Created by Benny Nguyen on 1/26/18.
//  Copyright © 2018 edu.uw.bennyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  var inBar: [String] = []
  @IBOutlet weak var changeText: UITextField!
  
  //Adds the label of the UIButton to the text bar if it's a number and records both numbers and operators for later calculations
  @IBAction func addToBar(_ sender: UIButton) {
    if Int(sender.titleLabel!.text!) != nil {
      changeText.text = sender.titleLabel!.text!
    }
    inBar.append(sender.titleLabel!.text!)
  }
  
  //Calculates the operation when the equals button is pressed using the inBar array of strings
  @IBAction func calculate(_ sender: UIButton) {
    if !inBar.isEmpty {
      var text: String = ""
      var firstNum: Int = Int(inBar[0])!
      let op: String = inBar[1]
      var secondNum: Int = 0
      if inBar.count >= 3 {
        secondNum = Int(inBar[2])!
      }
      switch op {
      case "fact":
        if firstNum == 0 {
          text = "0"
        } else {
          var sum: Int = 1
          for num in 1...firstNum {
            sum *= num
          }
          text = "\(sum)"
        }
      case "count":
        var sum: Int = 0
        for index in 0...inBar.count - 1 {
          if Int(inBar[index]) != nil {
            sum += 1
          }
        }
        text = "\(sum)"
      case "avg":
        var sum: Int = 0
        var totalNums: Int = 0
        for index in 0...inBar.count - 1 {
          if Int(inBar[index]) != nil {
            sum += Int(inBar[index])!
            totalNums += 1
          }
        }
        text = "\(sum / totalNums)"
      case "+":
        text = "\(firstNum + secondNum)"
      case "-":
        text = "\(firstNum - secondNum)"
      case "*":
        text = "\(firstNum * secondNum)"
      case "/":
        text = "\(firstNum / secondNum)"
      case "%":
        while firstNum > secondNum {
          firstNum = firstNum - secondNum
        }
        text = "\(firstNum)"
      default:
        text = "error!"
      }
      changeText.text = text
      inBar.removeAll()
    }
  }
}

