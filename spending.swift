//
//  spending.swift
//  Grounded
//
//  Created by artlawson on 6/27/20.
//  Copyright © 2020 artlawson. All rights reserved.
//

import UIKit

class spendingViewController: UIViewController {
    @IBOutlet weak var spendingField: UITextField!
    @IBOutlet weak var successLabel: UILabel!
    
    @IBAction func enterButtonPressed(_ sender: Any) {
        enterBtn()
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        spendingField.delegate = self
        self.successLabel.alpha = 0.0
        //add done button
        spendingField.addDoneButtonToKeyboard(myAction:  #selector(self.spendingField.resignFirstResponder))
        
        
    }
    
    
    //called when enter button pressed
    func enterBtn(){
        
        //put temporary display for successful saving
        
        let current = spendingField!.text ?? "0.00"
        //in optimizing, one of these two is not correct, difference may not matter now though
        let cur_dig = Double(current.digits) ?? 0.00 / 100
        global.WEEKLY_CURRENT += (cur_dig / 100)
        global.MONTHLY_CURRENT += (cur_dig / 100)
        global.YEARLY_CURRENT += (cur_dig / 100)
        
        //if field isn't empty/0's, show success label
        if  cur_dig  != 0.00{
            
            // fade in
            UIView.animate(withDuration: 1.0, delay: 0,options: .showHideTransitionViews, animations: {
                
                self.successLabel.alpha = 1.0
           }) { (finished) in
               // fade out
               UIView.animate(withDuration: 2.0, animations: {
                self.successLabel.alpha = 0.0
               })
                }
        }
        //empties text field
        spendingField.text = nil
       
        
    }
    
}

//used for tapping empty to end keyboard
extension spendingViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //allegedly these do the same thing
        //only endEditing is working tho?
        spendingField.resignFirstResponder()
        spendingField.endEditing(true)
        return true
    }
}
