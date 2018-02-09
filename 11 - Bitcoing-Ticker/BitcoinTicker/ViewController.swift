//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Updated by Scott Higgins on 02/08/2018
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let moneySymbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""
    var selectedRow = 0

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self

        getBitcoinPrice(url: baseURL + "AUD")
       
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        finalURL = baseURL + currencyArray[row]
        getBitcoinPrice(url: finalURL)
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getBitcoinPrice(url: String) {
        
        Alamofire.request(url, method: .get, parameters: nil)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    let priceJSON : JSON = JSON(response.result.value!)
                    self.updatePriceLabel(json: priceJSON)

                } else {
                    
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                    
                }
            }

    }
 
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updatePriceLabel(json : JSON) {
        if let bitPrice = json["ask"].double {
            bitcoinPriceLabel.text = moneySymbolArray[selectedRow] + String(bitPrice)
        } else {
            bitcoinPriceLabel.text = "Error :("
        }
    }
    




}

