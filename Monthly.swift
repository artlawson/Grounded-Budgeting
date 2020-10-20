//
//  Monthly.swift
//  Grounded
//
//  Created by artlawson on 6/8/20.
//  Copyright © 2020 artlawson. All rights reserved.
//

import UIKit

class monthlyViewController: UIViewController {
    @IBOutlet var monthlyHistoryTable: UITableView!
    var monthly_check = true

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        monthlyHistoryTable.delegate = self
        monthlyHistoryTable.dataSource = self
        
        //moved to current so it would refresh more often
        //let date = Date()
        //let calendar = Calendar.current
        //let components = calendar.dateComponents([.day], from: date)
        //global.MONTH_DAY = String(Double(components.day!))
        
        if global.MONTH_DAY == global.MONTH_RESET && monthly_check{
            global.MONTHLY_HISTORY.append(global.MONTHLY_CURRENT)
            global.MONTHLY_DATE_HIST.append(global.CURRENT_MONTH + " " + global.CURRENT_YEAR)
            global.MONTHLY_HIST_GOAL.append(global.MONTHLY_LIMIT)
            monthly_check = false
            //reset current
            global.MONTHLY_CURRENT = 0.0
        
           }
        else if global.MONTH_DAY != global.MONTH_RESET{
            monthly_check = true
        }
        
    }
   
   
}
    extension monthlyViewController: UITableViewDelegate{
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if global.MONTHLY_HISTORY.count == 0 {
                performSegue(withIdentifier: "mDetails", sender: self)
                global.VIEW_INCOMPLETE = true
                return
                
            }
            global.VIEW_INCOMPLETE = false
            global.VIEW_SPENDING = String(global.MONTHLY_HISTORY[indexPath.row])
            global.VIEW_DATE = String(global.MONTHLY_DATE_HIST[indexPath.row])
            global.VIEW_LIMIT = String(global.MONTHLY_HIST_GOAL[indexPath.row])
            global.VIEW_TIME = "month"
            if global.MONTHLY_HIST_GOAL[indexPath.row] > global.MONTHLY_HISTORY[indexPath.row]{
                global.VIEW_CONFIRM = true
            }
            else{global.VIEW_CONFIRM = false}
            performSegue(withIdentifier: "mDetails", sender: self)
            
        }
        
    }
    



    extension monthlyViewController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if global.MONTHLY_HISTORY.count == 0 {return 1}
            return global.MONTHLY_HISTORY.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //////want cell details to be date of that month
            let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyCell") as! weeklyCell
            
            
            // might want default cell for empty
            if global.MONTHLY_HISTORY.count == 0{
                cell.spendingLabel!.text = "Check back later!"
                cell.dateLabel.text = "----"
            }
            else{
                cell.spendingLabel!.text = zero_check(num: "$" + String(global.MONTHLY_HISTORY[indexPath.row]))
                

                cell.dateLabel.text = global.MONTHLY_DATE_HIST[indexPath.row]
            }
            return cell
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    }

