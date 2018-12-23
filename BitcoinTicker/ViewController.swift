//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Ales Shenshin on 21/12/2018.
//  Copyright © 2018 Ales Shenshin. All rights reserved.
//

//encoding with gpg

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbol = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]

    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        finalURL = baseURL + currencyArray[0]
        getBitcoinRate(url: finalURL, symbol: currencySymbol[0])
       
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "-=\(currencyArray[row])=-"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
        getBitcoinRate(url: finalURL, symbol: currencySymbol[row])
    }
    
    func getBitcoinRate(url: String, symbol: String){
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if response.result.isSuccess{
                let bitcoinJSON = JSON(response.result.value!)
                self.bitcoinPriceLabel.text = symbol + bitcoinJSON["last"].stringValue
            } else {
                print("Error: \(String(describing: response.result.error))")
                self.bitcoinPriceLabel.text = "Connection Issues"
            }
        }
    }
}

