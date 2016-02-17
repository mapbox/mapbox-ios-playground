//
//  ViewController.swift
//  VisualZipCode
//
//  Created by Tom MacWright on 2/17/16.
//  Copyright © 2016 Tom MacWright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bottomConstant: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func keyboardWillShow(notification: NSNotification) {
        print("Got show");
        self.view.layoutIfNeeded()
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            UIView.animateWithDuration(1, animations: {
                self.bottomConstant.constant = keyboardSize.height;
                self.view.layoutIfNeeded()
            })
        }
    }
}

