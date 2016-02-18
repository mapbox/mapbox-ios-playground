//
//  ViewController.swift
//  VisualZipCode
//
//  Created by Tom MacWright on 2/17/16.
//  Copyright © 2016 Tom MacWright. All rights reserved.
//

import UIKit
import SwiftCSV
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var bottomConstant: NSLayoutConstraint!
    
    var zipCodeData: [Dictionary<String, String>]!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        loadZipCodes();
    }
    
    func loadZipCodes()  {
        Alamofire.request(.GET, "https://macwright-org-tmp.s3.amazonaws.com/zipcodes.csv")
            .responseString { response in
                do {
                    if let csv = try CSV(content: response.result.value,
                        delimiter: NSCharacterSet(charactersInString: ","),
                        encoding: NSUTF8StringEncoding) as CSV? {
                            self.zipCodeData = csv.rows;
                    }
                } catch {
                    print("Failure");
                }
        }
    }
    
    @IBAction func zipCodeChanged(sender: UITextField, forEvent event: UIEvent) {
        func startsWithZip(row: Dictionary<String, String>) -> Bool {
            return row["Zipcode"]!.hasPrefix(sender.text!);
        }
        
        if self.zipCodeData != nil {
            let zipCodes = self.zipCodeData.filter(startsWithZip);
            var sw = [180.0, 90.0];
            var ne = [-180.0, -90.0];
            for code in zipCodes {
                if let lng = code["Longitude"],
                    lat = code["Latitude"] {
                    let lat = Double(lat)!;
                    let lng = Double(lng)!;
                    if (sw[0] > lng) {
                        sw[0] = lng;
                    }
                    if (sw[1] > lat) {
                        sw[1] = lat;
                    }
                        
                    if (ne[0] < lng) {
                        ne[0] = lng;
                    }
                    if (ne[1] < lat) {
                        ne[1] = lat;
                    }
                }
            }
        }
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Fix the layout so that when the keyboard is toggled,
    // the UI resizes to match
    func keyboardWillShow(notification: NSNotification) {
        self.view.layoutIfNeeded()
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            UIView.animateWithDuration(1, animations: {
                self.bottomConstant.constant = keyboardSize.height;
                self.view.layoutIfNeeded()
            })
        }
    }
    
}

