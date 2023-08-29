//
//  ConvertVC.swift
//  BM_Graduation_Project
//
//  Created by mohamed on 23/08/2023.
//

import UIKit
import iOSDropDown
import SDWebImage
typealias settingTableView = UITableViewDelegate & UITableViewDataSource
class ConvertVC: UIViewController {
    @IBOutlet weak var sourceAmount: UITextField!
    @IBOutlet weak var sourceCurrency: DropDown!
    @IBOutlet weak var toAmount: UITextField!
    @IBOutlet weak var toCurrency: DropDown!
    @IBOutlet weak var FavouriteTableview: UITableView!
    @IBOutlet weak var addtoFavouriteBtn: UIButton!
  
    var dataArr: [Favourite] = []
    var favArr: [Favourite] = []
    var convArr: Convert? 
    var favlist: [Double]?
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceCurrency.text = " " + getFlagEmoji(flag: "EGP") + "  EGP"
        toCurrency.text = " " + getFlagEmoji(flag: "USD") + "  USD"
        settingupUI()
        FavouriteTableview.register(UINib(nibName: cells.insideFavouriteCell, bundle: nil), forCellReuseIdentifier: cells.insideFavouriteCell)
        gettData()
//        getRates()
    }
    func gotoFavourite(){
        
        let sb = UIStoryboard(name:StoryBoards.main, bundle:nil) // create instance
        let favouriteVC = sb.instantiateViewController(withIdentifier: ViewControllerIds.favourite) as! FavouriteViewController
        favouriteVC.delegate = self
        self.present(favouriteVC, animated: true)
        
    }
    
    @IBAction func convertBtn(_ sender: UIButton) {
        getConvertData()
    }
    
    @IBAction func addToFavouriteBtn(_ sender: UIButton) {
        
        gotoFavourite()
    }
}
extension ConvertVC: CurrencyFavoriting {
    func favorite(currency: [Favourite]) {
      
       favArr.append(contentsOf: currency)
        FavouriteTableview.reloadData()
    }
}
extension ConvertVC {
    func getRates() {
        APIManager.getRatesData(data: Rates(base: "EGP"),currncyes: dataArr.map{
            $0.code ?? "EGP"
        }) { error, ratesArr in
            if let error = error {
                print(error)
                return
            }

            if let rates = ratesArr {
                DispatchQueue.main.async {
                    
                    self.favlist = rates
                    self.favArr = self.dataArr
                    self.FavouriteTableview.reloadData()
                    print(rates,"test")
                }
            }
        }
    }
    func getConvertData() {
        guard let base = sourceCurrency.text , let target = toCurrency.text  else {
            fatalError()
        }
        let startIndexbase = base.index(after: base.startIndex)
        let substringbase = base[startIndexbase..<base.endIndex]
        let startIndextarget = target.index(after: target.startIndex)
        let substringtarget = target[startIndextarget..<target.endIndex]

        APIManager.getConvertData(data: DataToConvert(amount: sourceAmount.text ?? "", base: String(substringbase), target: String(substringtarget))) { error, data in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                     self.convArr = data
                    self.toAmount.text = "\(self.convArr?.conversionResult ?? 0.0)"
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
                self.dataArr = data
                    self.toCurrency.optionArray = self.dataArr.map{
                        self.getFlagEmoji(flag: $0.code ?? " ") + ($0.code ?? "")
                    } as! [String]
                    
                    self.sourceCurrency.optionArray = self.dataArr.map{
                        self.getFlagEmoji(flag: $0.code ?? " ") + ($0.code ?? "")
                    } as! [String]
                    self.getRates()
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

    extension ConvertVC :settingTableView {

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCellTableViewCell", for: indexPath) as! favouriteCellTableViewCell
            let currency = favArr[indexPath.row]
            cell.imageCurrency.sd_setImage(with: URL(string: currency.flagURL!))
            cell.currencyName.text = currency.name
            cell.currencyLabel.text = currency.code
            cell.currencyRate.text =  "\(favlist?[indexPath.row] ?? 0.0)"
            return cell
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            favArr.count
        }
    }
    extension ConvertVC {
        func settingupUI() {
            sourceAmount.layer.borderWidth = 0.5
            sourceAmount.layer.cornerRadius = 20
            sourceAmount.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
            
            sourceCurrency.layer.borderWidth = 0.5
            sourceCurrency.layer.cornerRadius = 20
            sourceCurrency.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
            
            toAmount.layer.borderWidth = 0.5
            toAmount.layer.cornerRadius = 20
            toAmount.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
            
            toCurrency.layer.borderWidth = 0.5
            toCurrency.layer.cornerRadius = 20
            toCurrency.layer.borderColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).cgColor
            
            addtoFavouriteBtn.layer.borderWidth = 0.91
            addtoFavouriteBtn.layer.cornerRadius = 18.12
            addtoFavouriteBtn.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        }
        
    }
    

