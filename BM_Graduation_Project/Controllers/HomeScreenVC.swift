//
//  HomeScreen.swift
//  BM_Graduation_Project
//
//  Created by mohamed on 23/08/2023.
//

import UIKit

class HomeScreenVC: UIViewController {
    
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    @IBOutlet weak var convertSegmentView: UIView!
    @IBOutlet weak var compareSegmentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        convertSegmentView.superview?.bringSubviewToFront(convertSegmentView)
      
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            convertSegmentView.isHidden = false
            compareSegmentView.isHidden = true
            
        case 1:
            compareSegmentView.isHidden = false
            convertSegmentView.isHidden = true
        default:
            break
        }
    }
}

