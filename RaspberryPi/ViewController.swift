//
//  ViewController.swift
//  RaspberryPi
//
//  Created by 板谷晃良 on 2016/02/27.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var inputText1: UITextField!
    @IBOutlet weak var inputText2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inputText1.delegate = self
        inputText2.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickButton(sender: AnyObject) {
        if inputText1.text != "" && inputText2.text != "" {
            let title = inputText1.text!
            let note  = inputText2.text!
            /*
            let str = "http://192.168.1.21/RaspberryOne.php?title=\(title)&note=\(note)"
            let url = NSURL(string: str)
            let req = NSURLRequest(URL: url!)
            */
            let stringUrl = "http://192.168.1.21/RaspberryOne.php?title=\(title)&note=\(note)"
            let URL = NSURL(string: stringUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
            let req = NSURLRequest(URL: URL)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(req, completionHandler: {
                (data, res, err) in
                if data != nil {
                    let text = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.resultLabel.text = text as String?
                    })
                }else{
                    dispatch_async(dispatch_get_main_queue(), {
                        self.resultLabel.text = "ERROR"
                    })
                }
            })
            task.resume()
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool{
        //Close keyboard.
        textField.resignFirstResponder()
        
        return true
    }
}

