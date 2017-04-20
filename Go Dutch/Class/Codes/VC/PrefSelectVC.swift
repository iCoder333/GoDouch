//
//  PrefSelectVC.swift
//  Go Dutch
//
//  Created by Mario Romano on 9/3/16.
//  Copyright © 2016 Sergey Bill. All rights reserved.
//

import UIKit

extension PrefSelectVC: GMPickerDelegate {
    
    func gmPicker(_ gmPicker: GMPicker, didSelect string: String) {
        
        if !isPrefSelected
        {
            lbl_iam.text = string
        }
        else
        {
            lbl_pref.text = string
        }
        
    }
    
    func gmPickerDidCancelSelection(_ gmPicker: GMPicker){
        
    }
    
    fileprivate func setupPickerView(){
        
        picker.delegate = self
        picker.config.animationDuration = 0.5
        
        picker.config.cancelButtonTitle = "Cancel"
        picker.config.confirmButtonTitle = "Confirm"
        
        picker.config.contentBackgroundColor = UIColor(red: 253/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1)
        picker.config.headerBackgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1)
        picker.config.confirmButtonColor = Color_Red
        picker.config.cancelButtonColor = Color_Red
    }
}

class PrefSelectVC: BasicVC {
    
    @IBOutlet weak var lbl_iam: UILabel!
    @IBOutlet weak var lbl_pref: UILabel!
    
    var picker = GMPicker()
    var isPrefSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupPickerView()
    }
    
    func showPicker(_ str : String)
    {
        let index = (str != "Select") ? picker.Array.index(of: str) : 0
        picker.gmpicker.selectRow(index!, inComponent: 0, animated: false)
        picker.placementAnswer = (str != "Select") ? str : picker.Array[0]
        
        picker.show(inVC: self)
    }
    
    @IBAction func onSelectIam(_ sender: AnyObject) {
        
        isPrefSelected = false
        picker.setupGender()

        self.showPicker(lbl_iam.text!)
    }
    
    @IBAction func onSelectPref(_ sender: AnyObject) {
        
        isPrefSelected = true
        picker.setupAllGender()

        self.showPicker(lbl_pref.text!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
