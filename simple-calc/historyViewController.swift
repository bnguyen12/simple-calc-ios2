//
//  historyViewController.swift
//  simple-calc
//
//  Created by Benny Nguyen on 1/30/18.
//  Copyright © 2018 edu.uw.bennyn. All rights reserved.
//

import UIKit

class historyViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      if !wordBank.isEmpty {
        for index in 0...wordBank.count - 1 {
          let label = UILabel(frame: CGRect(x: 50, y: index * 25 + 50, width: 300, height: 40))
          label.text = wordBank[index]
          //view.addSubview(label)
          scrollView.addSubview(label)
        }
      }
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let calcView = segue.destination as! ViewController
    calcView.wordBank = wordBank
  }
  
  @IBOutlet weak var scrollView: UIScrollView!
  var wordBank: [String] = []

}
