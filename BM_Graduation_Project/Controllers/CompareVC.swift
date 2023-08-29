//
//  CompareVC.swift
//  BM_Graduation_Project
//
//  Created by mohamed on 23/08/2023.
//

import UIKit
import iOSDropDown
class CompareVC: UIViewController {

    @IBOutlet weak var sourceAmount: UITextField!
    @IBOutlet weak var sourceCurrency: DropDown!
    @IBOutlet weak var firstTargetedAmount: UITextField!
    @IBOutlet weak var secondTargetedAmount: UITextField!
    @IBOutlet weak var firstCurrency: DropDown!
    @IBOutlet weak var secondCurrency: DropDown!

    var favArr: [Favourite] = []
    var compareArr: Compare?
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceCurrency.text = " " + getFlagEmoji(flag: "EGP") + "  EGP"
        firstCurrency.text = " " + getFlagEmoji(flag: "USD") + "  USD"
        secondCurrency.text = " " + getFlagEmoji(flag: "EUR") + "  EUR"
        settingupUI()
         gettData()
       
    }
    
    @IBAction func compareBtn(_ sender: UIButton) {
        getCompareData()
    }
}
extension CompareVC {
    func getCompareData() {
        
        guard let base = sourceCurrency.text , let target1 = firstCurrency.text, let target2 = firstCurrency.text  else {
            fatalError()
        }
        let startIndexbase = base.index(after: base.startIndex)
        let substringbase = base[startIndexbase..<base.endIndex]
        let startIndextarget1 = target1.index(after: target1.startIndex)
        let substringtarget1 = target1[startIndextarget1..<target1.endIndex]
        let startIndextarget2 = target2.index(after: target2.startIndex)
        let substringtarget2 = target2[startIndextarget2..<target2.endIndex]
        
        APIManager.getCompareData(data: DataToCompare(amount: sourceAmount.text ?? "", base: String(substringbase), target1: String(substringtarget1), target2:String(substringtarget2))) { error, data in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    self.compareArr = data
                    
                    if let firstTargetCurrency = self.compareArr?.firstTargetCurrency?.conversionResult {
                        self.firstTargetedAmount.text = String(format: "%.4f", firstTargetCurrency)
                    }
                    if let secondTargetCurrency = self.compareArr?.secondTargetCurrency?.conversionResult {
                        self.secondTargetedAmount.text = String(format: "%.4f", secondTargetCurrency)
                    }
                }
            }
        }
    }

    func gettData() {
        APIManager.getFavouriteData {  error , data in
            
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    self.favArr = data
                    self.sourceCurrency.optionArray = self.favArr.map{
                        self.getFlagEmoji(flag: $0.code ?? " ") + ($0.code ?? "")
                    } as! [String]
                    self.firstCurrency.optionArray = self.favArr.map{
                        self.getFlagEmoji(flag: $0.code ?? " ") + ($0.code ?? "")
                    } as! [String]
                    self.secondCurrency.optionArray = self.favArr.map{
                        self.getFlagEmoji(flag: $0.code ?? " ") + ($0.code ?? "")
                    } as! [String]

                    }
                }
                
            }
                        
        }
    func getFlagEmoji(flag: String) -> String{
        let code = flag.dropLast()
            let base: UInt32 = 127397
            var emoji = ""
            for scalar in code.unicodeScalars {
                emoji.append(String(UnicodeScalar(base + scalar.value)!))
            }
            return emoji
        }
}
extension CompareVC {
    func settingupUI() {
        sourceAmount.layer.borderWidth = 0.5
        sourceAmount.layer.cornerRadius = 20
        sourceAmount.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
        
        sourceCurrency.layer.borderWidth = 0.5
        sourceCurrency.layer.cornerRadius = 20
        sourceCurrency.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
        
        firstTargetedAmount.layer.borderWidth = 0.5
        firstTargetedAmount.layer.cornerRadius = 20
        firstTargetedAmount.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
        
        secondTargetedAmount.layer.borderWidth = 0.5
        secondTargetedAmount.layer.cornerRadius = 20
        secondTargetedAmount.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
        
        firstCurrency.layer.borderWidth = 0.5
        firstCurrency.layer.cornerRadius = 20
        firstCurrency.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
        secondCurrency.layer.borderWidth = 0.5
        secondCurrency.layer.cornerRadius = 20
        secondCurrency.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
    }

    }
