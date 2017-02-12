//
//  ViewController.swift
//  RaspberryPi
//
//  Created by 板谷晃良 on 2016/02/27.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //PHP
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var inputText1: UITextField!
    @IBOutlet weak var inputText2: UITextField!
    //Rails
    @IBOutlet weak var resultLabelR: UILabel!
    @IBOutlet weak var inputTextR1: UITextField!
    @IBOutlet weak var inputTextR2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inputText1.delegate = self
        inputText2.delegate = self
        inputTextR1.delegate = self
        inputTextR2.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickButton(_ sender: AnyObject) {
        if inputText1.text != "" && inputText2.text != "" {
            let title = inputText1.text!
            let note  = inputText2.text!
            /*
            let str = "http://192.168.1.21/RaspberryOne.php?title=\(title)&note=\(note)"
            let url = NSURL(string: str)
            let req = NSURLRequest(URL: url!)
            */
            let stringUrl = "http://192.168.1.21/RaspberryOne.php?title=\(title)&note=\(note)"
            let url = URL(string: stringUrl.addingPercentEscapes(using: String.Encoding.utf8)!)!
            let req = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: req, completionHandler: {
                (data, res, err) in
                if data != nil {
                    let text = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    DispatchQueue.main.async(execute: {
                        self.resultLabel.text = text as String?
                    })
                }else{
                    DispatchQueue.main.async(execute: {
                        self.resultLabel.text = "ERROR"
                    })
                }
            })
            task.resume()
        }else{
            alert("error", messageString: "It is not entered.", buttonString: "OK")
        }
    }
    
    @IBAction func clickButtonR(_ sender: AnyObject) {
        if inputTextR1.text != "" && inputTextR2.text != "" {
            let title = inputTextR1.text!
            let note  = inputTextR2.text!
            
            let stringUrl = "http://192.168.1.21:3000/?title=\(title)&note=\(note)"
            let url = URL(string: stringUrl.addingPercentEscapes(using: String.Encoding.utf8)!)!
            let req = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: req, completionHandler: {
                (data, res, err) in
                if data != nil {
                    let text = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    DispatchQueue.main.async(execute: {
                        self.resultLabelR.text = text as String?
                    })
                }else{
                    DispatchQueue.main.async(execute: {
                        self.resultLabelR.text = "ERROR"
                    })
                }
            })
            task.resume()
        }else{
            alert("error", messageString: "It is not entered.", buttonString: "OK")
        }
    }
    
    func alert(_ titleString: String, messageString: String, buttonString: String){
        //Create UIAlertController
        let alert: UIAlertController = UIAlertController(title: titleString, message: messageString, preferredStyle: .alert)
        //Create action
        let action = UIAlertAction(title: buttonString, style: .default) { action in
            NSLog("\(titleString):Push button!")
        }
        //Add action
        alert.addAction(action)
        //Start
        present(alert, animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        //Close keyboard.
        textField.resignFirstResponder()
        
        return true
    }
}

