//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    
    
    
    

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    var coinManager = CoinManager()
    var coinData: CoinModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        coinManager.getCoinPrice(for: "USD")
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectCurrency)
        
        currencyLabel.text = selectCurrency
    }
    
    
    func didUpdateCoin(coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(coin.rate)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


