//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var coinManager=CoinManager()
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource=self
        currencyPicker.delegate=self
        coinManager.delegate=self
    }

}
//MARK: - CoinManagerDelegate
extension ViewController:CoinManagerDelegate{
    func didUpdateRate(coinData:CoinData){
        DispatchQueue.main.sync {
            currencyLabel.text=coinData.asset_id_quote
            bitcoinLabel.text=String(format: "%.2f", coinData.rate)
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
//MARK: - UIPickerView
extension ViewController:UIPickerViewDataSource, UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print(coinManager.currencyArray[row])
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}
