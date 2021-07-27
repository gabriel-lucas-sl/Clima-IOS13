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
    var bitcoinSelected: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        bitcoinSelected = coinManager.currencyArray[row]
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCoin = coinManager.currencyArray[row]
        
        coinManager.getCoinPrice(for: selectedCoin)
    }
    
    func didUpdateCoin(_ coinManager: CoinManager, _ coin: CoinDataModel) {
        let bitcoin = String(format: "%.1f", coin.rate)
        DispatchQueue.main.async {
            self.bitcoinLabel.text = bitcoin
            self.currencyLabel.text = self.bitcoinSelected
        }
    }
    
    func didFailedWithError(_ error: Error) {
        print("We got an error \n", error)
    }
}

