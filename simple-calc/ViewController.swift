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
  
  //Adds the label of the UIButton to the text bar if it's a number and records
  //both numbers and operators for later calculations
  @IBAction func addToBar(_ sender: UIButton) {
    if Float(sender.titleLabel!.text!) != nil { //if it's a valid number
      if !inBar.isEmpty && (inBar.last!.contains(".") || Float(inBar.last!) != nil) {
        inBar.append(inBar.removeLast() + sender.titleLabel!.text!)
      } else {
        inBar.append(sender.titleLabel!.text!)
      }
      changeText.text = inBar.last
    } else if sender.titleLabel!.text! == "." {
      inBar.append(inBar.removeLast() + ".")
      changeText.text = inBar.last
    } else { //for operators
      inBar.append(sender.titleLabel!.text!)
    }
  }
  
  //Calculates the operation when the equals button is pressed using the inBar
  //array of strings
  @IBAction func calculate(_ sender: UIButton) {
    if !inBar.isEmpty {
      var text: String = ""
      var firstNum: Float = Float(inBar[0])!
      let op: String = inBar[1]
      var secondNum: Float = 0
      if inBar.count >= 3 {
        secondNum = Float(inBar[2])!
      }
      switch op {
      case "fact":
        if firstNum == 0 {
          text = "0"
        } else {
          var sum: Int = 1
          for num in 1...Int(firstNum) {
            sum *= num
          }
          text = "\(sum)"
        }
      case "count":
        var sum: Float = 0
        for index in 0...inBar.count - 1 {
          if Float(inBar[index]) != nil {
            sum += 1
          }
        }
        text = "\(sum)"
      case "avg":
        var sum: Float = 0
        var totalNums: Float = 0
        for index in 0...inBar.count - 1 {
          if Float(inBar[index]) != nil {
            sum += Float(inBar[index])!
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
  
  //Clears all the numbers in the bar and clears all current operations going on
  @IBAction func clearAll(_ sender: UIButton) {
    changeText.text = ""
    inBar.removeAll()
  }
}

