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
  @IBOutlet weak var enterButton: UIButton!
  var RPNstatus: Bool = false
  
  //Toggles whether reverse polish notation is on or not
  @IBAction func RPNtoggle(_ sender: UIButton) {
    RPNstatus = !RPNstatus
    enterButton.isHidden = !enterButton.isHidden
  }
  
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
      var secondNum: Float = 0
      var op: String = inBar[1]
      if RPNstatus {
        stripArray("enter")
        op = inBar[inBar.count - 1]
        if inBar.count != 2 { //if we're not doing a factorial
          secondNum = Float(inBar[1])!
        }
      } else if inBar.count > 2 { //if we're doing an op that isn't a factorial
        secondNum = Float(inBar[2])!
      }
      switch op {
      case "fact":
        if firstNum == 0 {
          text = "1"
        } else {
          var sum: Int = 1
          for num in 1...Int(firstNum) {
            sum *= num
          }
          text = "\(sum)"
        }
      case "count":
        stripArray("count")
        var sum: Float = 0
        for _ in 0...inBar.count - 1 {
          sum += 1
        }
        text = "\(sum)"
      case "avg":
        stripArray("avg")
        var sum: Float = 0
        for index in 0...inBar.count - 1 {
          sum += Float(inBar[index])!
        }
        text = "\(sum / Float(inBar.count))"
      case "+":
        text = "\(firstNum + secondNum)"
      case "-":
        text = "\(firstNum - secondNum)"
      case "*":
        text = "\(firstNum * secondNum)"
      case "/":
        text = "\(firstNum / secondNum)"
      case "%":
        if secondNum == 0 {
          text = "\(secondNum)"
        } else {
          while firstNum >= secondNum {
            firstNum = firstNum - secondNum
          }
        text = "\(firstNum)"
        }
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
  
  //Strips an array of anything that matches the given String
  func stripArray(_ word: String) {
    for element in inBar.reversed() {
      if element == word {
        inBar.remove(at: inBar.index(of: element)!)
      }
    }
  }
}

