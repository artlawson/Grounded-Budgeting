//
//  set.swift
//  Grounded
//
//  Created by artlawson on 6/10/20.
//  Copyright © 2020 artlawson. All rights reserved.
//

import UIKit



class setViewController: UIViewController {
    
    //vars and or outlets
    @IBOutlet weak var weeklyField: UITextField!
    @IBOutlet weak var monthlyField: UITextField!
    @IBOutlet weak var yearlyField: UITextField!
    @IBOutlet weak var weeklyLabel: UILabel!
    @IBOutlet weak var monthlyLabel: UILabel!
    @IBOutlet weak var yearlyLabel: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    var editMode: Bool = true
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //field setup
        weeklyField.delegate = self
        monthlyField.delegate = self
        yearlyField.delegate = self
        self.txt_font_scalar(obj: weeklyField)
        self.txt_font_scalar(obj: monthlyField)
        self.txt_font_scalar(obj: yearlyField)
        
        //add done button
        weeklyField.addDoneButtonToKeyboard(myAction:  #selector(self.weeklyField.resignFirstResponder))
        monthlyField.addDoneButtonToKeyboard(myAction:  #selector(self.monthlyField.resignFirstResponder))
        yearlyField.addDoneButtonToKeyboard(myAction:  #selector(self.yearlyField.resignFirstResponder))
        //label setup
        weeklyLabel.text = ""
        monthlyLabel.text = ""
        yearlyLabel.text = ""
        self.lbl_font_scalar(obj: weeklyLabel)
        self.lbl_font_scalar(obj: monthlyLabel)
        self.lbl_font_scalar(obj: yearlyLabel)
        
        //makes enterButton sclae
        enterButton.setDynamicFontSize()
        
        //initially hide labels
        weeklyLabel.isHidden = true
        monthlyLabel.isHidden = true
        yearlyLabel.isHidden = true
        
        weeklyLabel.layer.cornerRadius = 10.0
        weeklyLabel.layer.masksToBounds = true
        monthlyLabel.layer.cornerRadius = 10.0
        monthlyLabel.layer.masksToBounds = true
        yearlyLabel.layer.cornerRadius = 10.0
        yearlyLabel.layer.masksToBounds = true
        
        // fade in
        UIView.animate(withDuration: 1.0, delay: 0,options: .showHideTransitionViews, animations: {
            
            self.purposeLabel.alpha = 5.0
       }) { (finished) in
           // fade out
           UIView.animate(withDuration: 5.0, animations: {
            self.purposeLabel.alpha = 0.0
           })
            }
        
        
        
        
    }

    
    //touch screen also exits
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        weeklyField.resignFirstResponder()
        monthlyField.resignFirstResponder()
        yearlyField.resignFirstResponder()
    }
    //enter/edit button pressed
    @IBAction func enterBtnPressed(_ sender: Any) {
        switch editMode{
        case true:
            self.editFunc()
        case false:
            self.enterFunc()
        }
    
    }
    //for initial view
    @IBAction func nextBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "starter0", sender: (Any).self)
        }
    
    
    
    //edit button pressed
    func enterFunc(){
        //turns on edit mode
        enterButton.setTitle("Enter", for: UIControl.State.normal)
        //make text fields appear
        weeklyField.isHidden = false
        monthlyField.isHidden = false
        yearlyField.isHidden = false
        //show labels
        weeklyLabel.isHidden = true
        monthlyLabel.isHidden = true
        yearlyLabel.isHidden = true
        editMode = true
  
    }
    //enter button pressed
    func editFunc(){
        //submits numbers
        enterButton.setTitle("Edit", for: UIControl.State.normal)
        var week = weeklyField!.text!
        var month = monthlyField!.text!
        var year = yearlyField!.text!
        
        //no input provides default labels
        //also sets globals
        if week == "" || week == "0.00" {
            week = "No weekly goal set"
            
        }
        else {global.WEEKLY_LIMIT = Double(week.digits)! / 100}
        
        if month == "" || month == "0.00" {
            month = "No monthly goal set"
            
        }
        else {global.MONTHLY_LIMIT = Double(month.digits)! / 100}
        
        if year == "" || year == "0.00"{
        //&& Double(year)! != global.YEARLY_LIMIT <<<<<<<----- implement when ready to use time stamps
            year = "No yearly goal set"
            
        }
        else {global.YEARLY_LIMIT = Double(year.digits)! / 100}
        
        weeklyLabel.text = "\(week)"
        monthlyLabel.text = "\(month)"
        yearlyLabel.text = "\(year)"
        
        //make text fields disappear
        weeklyField.isHidden = true
        monthlyField.isHidden = true
        yearlyField.isHidden = true
        //hide labels
        weeklyLabel.isHidden = false
        monthlyLabel.isHidden = false
        yearlyLabel.isHidden = false
        editMode = false
        
        
    }
    
}

//used for tapping empty to end keyboard
extension setViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//class for currency text field!
@IBDesignable open class CurrencyTextField : UITextField {
    
    private let maxDigits = 12
    //private var defaultValue = 0.00
    private let currencyFormatter = NumberFormatter()
    private var previousValue = ""
    
    var value: Double {
        get { return Double(getCleanNumberString()) ?? 0 / 100 }
        set { setAmount(newValue) }
    }
    
    // MARK: - init functions
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initTextField()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initTextField()
    }
    
    func initTextField(){
        self.keyboardType = UIKeyboardType.decimalPad
        currencyFormatter.numberStyle = .currency
        currencyFormatter.minimumFractionDigits = 2
        currencyFormatter.maximumFractionDigits = 2
        
    }
    
    
    // MARK: - UITextField Notifications
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: self)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        let cursorOffset = getOriginalCursorPosition()
        let cleanNumericString = getCleanNumberString()
        let textFieldLength = text?.count
        let textFieldNumber = Double(cleanNumericString)
        
        if cleanNumericString.count <= maxDigits && textFieldNumber != nil {
            setAmount(textFieldNumber! / 100)
        } else {
            text = previousValue
        }
        
        setCursorOriginalPosition(cursorOffset, oldTextFieldLength: textFieldLength)
    }
    
    //MARK: - Custom text field functions
    
    private func setAmount (_ amount : Double){
        let textFieldStringValue = currencyFormatter.string(from: NSNumber(value: amount))
        text = textFieldStringValue
        textFieldStringValue.flatMap { previousValue = $0 }
    }
    
    //MARK - helper functions
    
    private func getCleanNumberString() -> String {
        return text?.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined() ?? ""
    }
    
    private func getOriginalCursorPosition() -> Int{
        guard let selectedTextRange = selectedTextRange else { return 0 }
        return offset(from: beginningOfDocument, to: selectedTextRange.start)
    }
    
    
    private func setCursorOriginalPosition(_ cursorOffset: Int, oldTextFieldLength : Int?) {
        let newLength = text?.count
        let startPosition = beginningOfDocument
        if let oldTextFieldLength = oldTextFieldLength, let newLength = newLength, oldTextFieldLength > cursorOffset {
            let newOffset = newLength - oldTextFieldLength + cursorOffset
            let newCursorPosition = position(from: startPosition, offset: newOffset)
            if let newCursorPosition = newCursorPosition {
                let newSelectedRange = textRange(from: newCursorPosition, to: newCursorPosition)
                selectedTextRange = newSelectedRange
            }
        }
    }
}

extension UITextField{

 func addDoneButtonToKeyboard(myAction:Selector?){
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    doneToolbar.barStyle = UIBarStyle.default

    let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)

    var items = [UIBarButtonItem]()
    items.append(flexSpace)
    items.append(done)

    doneToolbar.items = items
    doneToolbar.sizeToFit()

    self.inputAccessoryView = doneToolbar
 }
}

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
