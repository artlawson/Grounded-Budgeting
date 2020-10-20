//
//  Weekly.swift
//  Grounded
//
//  Created by artlawson on 7/2/20.
//  Copyright © 2020 artlawson. All rights reserved.
//

import UIKit

// NEED TO TEST THE DATE CHANGE
//one check comes in setting the day in datepickerW

class weeklyViewController: UIViewController {
    @IBOutlet var weeklyHistoryTable: UITableView!
    
    var weekly_check = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weeklyHistoryTable.delegate = self
        weeklyHistoryTable.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        //sets values in a place that will constantly update!
        
        if Date().dayNumberOfWeek() == global.WEEK_RESET && weekly_check{
            //this is where I'll add additional connection for goal array (maybe dictionary with key = limit, value = arr of dates in there :)
            global.WEEKLY_HISTORY.append( global.WEEKLY_CURRENT)
            global.WEEKLY_DATE_HIST.append(global.WEEK_START)
            global.WEEKLY_HIST_GOAL.append(global.WEEKLY_LIMIT)
            //reset current
            global.WEEKLY_CURRENT = 0.0
            //set weekly start to today
            global.WEEK_START = global.CURRENT_DATE
            // have bool that changes?
            weekly_check = false
        
        }
        else if Date().dayNumberOfWeek() != global.WEEK_RESET {
            weekly_check = true
            
        }
        
        
    }
    
    
    //then make sure it creates cell
    //can you spending/current for if statement to make sure it works
    
}

//returns 1-7 with 1 being Sunday and 7 being Saturday
extension Date{
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}


extension weeklyViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if global.WEEKLY_HISTORY.count == 0 {
            
            performSegue(withIdentifier: "wDetails", sender: self)
            global.VIEW_INCOMPLETE = true
            return
        
        }
        global.VIEW_INCOMPLETE = false
        global.VIEW_SPENDING = String(global.WEEKLY_HISTORY[indexPath.row])
        global.VIEW_DATE = "The week starting on " + String(global.WEEKLY_DATE_HIST[indexPath.row])
        global.VIEW_LIMIT = String(global.WEEKLY_HIST_GOAL[indexPath.row])
        global.VIEW_TIME = "week"
        if global.WEEKLY_HIST_GOAL[indexPath.row] > global.WEEKLY_HISTORY[indexPath.row]{
            global.VIEW_CONFIRM = true
        }
        else{global.VIEW_CONFIRM = false}
        performSegue(withIdentifier: "wDetails", sender: self)
    }
    
    
}

extension weeklyViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if global.WEEKLY_HISTORY.count == 0 {return 1}
        return global.WEEKLY_HISTORY.count
    }
     func viewWillappear( animated: Bool){
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //////want cell details to be date of that week
        let cell = tableView.dequeueReusableCell(withIdentifier: "weeklyCell") as! weeklyCell
        
        if global.WEEKLY_HISTORY.count == 0 {
            cell.spendingLabel!.text = "Check back later!"
            cell.dateLabel!.text = "-- -- --"
        }
        else {
            cell.spendingLabel.text = zero_check(num: "$" + String(global.WEEKLY_HISTORY[indexPath.row]))
            
           
            
            cell.dateLabel.text = global.WEEKLY_DATE_HIST[indexPath.row] //check this to make sure it works :)
            //now it works <3
        }
        //cell text color
        //cell.spendingLabel.textColor = UIColor .white
    
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
