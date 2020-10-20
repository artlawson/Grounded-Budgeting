//
//  DatePickerM.swift
//  Grounded
//
//  Created by artlawson on 7/9/20.
//  Copyright © 2020 artlawson. All rights reserved.
//

import UIKit

//have label/textfield setup like set view

class dateViewControllerM: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var currentResetLbl: UILabel!
    
    
    //number of colums
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //temp reset
    var temp_reset = global.MONTH_RESET
    
    //items in list
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daySelectorData.count
    }
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return daySelectorData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dateField.text = daySelectorData[row]
        self.temp_reset = daySelectorData[row]
        //moved to doneBtn Pressed so no accidental resets
        //global.MONTH_RESET = daySelectorData[row]
        
        
    }
    
    
    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var dateField: UITextField!
    var daySelector = UIPickerView()
    var daySelectorData: [String] = [String]()
    
    
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        createDayPicker()
        animateLabel()
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        currentResetLbl.text = "Your monthly spending currently resets on the " + formatter.string(from: Int(global.MONTH_RESET)! as NSNumber)! + " of the month!"
        daySelectorData = []
        for i in 1...28{
            if i < 10 {
                daySelectorData.append("0" + String(i))
            }
            else{
            daySelectorData.append(String(i))
            }
            
        }
    
        daySelector.delegate = self
        daySelector.dataSource = self
    }

    
    func createDayPicker(){
        //toolbar
        dateField.textAlignment = .center
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //Done Btn
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        //add doneBtn to toolbar
        toolbar.setItems([doneBtn], animated: true)
        
        dateField.inputAccessoryView = toolbar
        dateField.inputView = daySelector
        

    }
    //action for when done button is pressed
    @objc func donePressed(){
        global.MONTH_RESET = self.temp_reset
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        currentResetLbl.text = "Your monthly spending now resets on the " + formatter.string(from: Int(global.MONTH_RESET)! as NSNumber)! + " of the month!"
        self.view.endEditing(true)
    }
    
    func animateLabel(){
    UIView.animate(withDuration: 1.0, delay: 0,options: .showHideTransitionViews, animations: {
         
         self.choiceLabel.alpha = 5.0
    }) { (finished) in
        // fade out
        UIView.animate(withDuration: 5.0, animations: {
         self.choiceLabel.alpha = 0.0
        })
         }
    }
    
    
}

