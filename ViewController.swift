//
//  ViewController.swift
//  Coldic
//
//  Created by demirci on 22/10/2016.
//  Copyright © 2016 mdemirci. All rights reserved.
//



import UIKit
import GoogleMobileAds

class ViewController: UIViewController,UITextFieldDelegate, GADBannerViewDelegate {
    
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var word: UITextField!
    
    @IBOutlet var vocab_txt: UITextView!
    var vocab_text : String = ""
    @IBOutlet var WebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let request : GADRequest = GADRequest()
        request.testDevices = [kGADSimulatorID]
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-3609786324133203/4891516576"
        bannerView.rootViewController = self
        bannerView.load(request)
        
        ////
        get_vocab(word: "conformity")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SearchButtonTapped(_ sender: AnyObject) {
        
        if word.text != nil {
            get_vocab(word: word.text!)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        if word.text != nil {
            get_vocab(word: word.text!)
        }
        return true;
    }
    func get_vocab(word : String){
        vocab_text = ""
        if let data = try? Data(contentsOf: URL(string: "http://oxforddictionary.so8848.com/search?word=\(word)")! ){
            let doc = TFHpple(htmlData: data)
            if let elements = doc?.search(withXPathQuery: "//div[@class='item']//p") as? [TFHppleElement]{
                
                
                for element in elements{
                 
                    print("element -> \(element.content!)")
                    
                    vocab_text += element.content + "\n\n\n"
                    //
                }
            }
            
        }
        vocab_txt.text = vocab_text
        
    }
    
    
    func Search(){
        if word.text! != "" {
            let WordURL = URL(string: "http://www.ozdic.com/collocation-dictionary/\(word.text!)")
            WebView.loadRequest(URLRequest(url: WordURL!))
        }
    }
    
}

