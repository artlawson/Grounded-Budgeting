//
//  Current.swift
//  Grounded
//
//  Created by artlawson on 6/8/20.
//  Copyright © 2020 artlawson. All rights reserved.
//

import UIKit

//current / goal
//if current > goal, text = red


//bool for first time in the current view
//will set outside view as setters
//enter buttons will be what segues people

class CurrentViewController: UIViewController {
    @IBOutlet weak var weeklyLabel: UILabel!
    @IBOutlet weak var monthlyLabel: UILabel!
    @IBOutlet weak var yearlyLabel: UILabel!
    
    
    @IBAction func WeeklyPress(_ sender: Any) {
        self.performSegue(withIdentifier: "WeeklySeg", sender: self)
    }
    
    @IBAction func MonthlyPress(_ sender: Any) {
        self.performSegue(withIdentifier: "MonthlySeg", sender: self)
    }
    @IBAction func YearlyPress(_ sender: Any) {
        self.performSegue(withIdentifier: "YearlySeg", sender: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        //if the double value doesn't end in 0, we append a 0 at the end
        let week_t = zero_check(num: String(global.WEEKLY_CURRENT))
        let month_t = zero_check(num: String(global.MONTHLY_CURRENT))
        let year_t = zero_check(num: String(global.YEARLY_CURRENT))
        let week_y = zero_check(num: String(global.WEEKLY_LIMIT))
        let month_y = zero_check(num: String(global.MONTHLY_LIMIT))
        let year_y = zero_check(num: String(global.YEARLY_LIMIT))
        
        
        //sets values in a place that will constantly update!
        weeklyLabel.text = "$" + week_t + " / $" + week_y
        monthlyLabel.text = "$" + month_t + " / $" + month_y
        yearlyLabel.text = "$" + year_t + " / $" + year_y
        
        
        
        //sets different colors for while under or over limit
        //week
        if global.WEEKLY_CURRENT > global.WEEKLY_LIMIT{
            weeklyLabel.textColor = UIColor.red
        }
        else {weeklyLabel.textColor = UIColor.green}
        //month
        if global.MONTHLY_CURRENT > global.MONTHLY_LIMIT{
            monthlyLabel.textColor = UIColor.red
        }
        else {monthlyLabel.textColor = UIColor.green}
        //year
        if global.YEARLY_CURRENT > global.YEARLY_LIMIT{
            yearlyLabel.textColor = UIColor.red
        }
        else {yearlyLabel.textColor = UIColor.green}
        
        //month day
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        global.MONTH_DAY = String(Double(components.day!))
        //current date
        let currentDateTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        global.CURRENT_DATE = dateFormatter.string(from: currentDateTime)
        //current year
        let deteFormatter = DateFormatter()
        deteFormatter.dateFormat = "YYYY"
        global.CURRENT_YEAR = deteFormatter.string(from: currentDateTime)
        //current Month
        let dteFormatter = DateFormatter()
        dteFormatter.dateFormat = "LLLL"
        global.CURRENT_MONTH = dteFormatter.string(from: currentDateTime)
        
       
        
        
        
        

    }


}
//used for tapping empty to end keyboard

// fixxxxxxxx
extension CurrentViewController{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.endEditing(true)
        
        return true
    }
}
