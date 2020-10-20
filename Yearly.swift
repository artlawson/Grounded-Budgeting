//
//  Yearly.swift
//  Grounded
//
//  Created by artlawson on 6/8/20.
//  Copyright © 2020 artlawson. All rights reserved.
//

import UIKit

class yearlyViewController: UIViewController {
    @IBOutlet weak var yearlyHistoryTable: UITableView!
    var yearly_check = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yearlyHistoryTable.delegate = self
        yearlyHistoryTable.dataSource = self
        
        if global.MONTH_DAY == "01" && global.CURRENT_MONTH == "January"  && yearly_check{
           global.YEARLY_HISTORY.append(global.MONTHLY_CURRENT)
            global.YEARLY_DATE_HIST.append(global.YEAR_START)
            global.YEARLY_HIST_GOAL.append(global.YEARLY_LIMIT)
           yearly_check = false
            //reset current
            global.YEARLY_CURRENT = 0.0
        
           }
        else if global.MONTH_DAY == "01" && global.CURRENT_MONTH == "January"{
            yearly_check = true
        }
        
    }
        
    }

    extension yearlyViewController: UITableViewDelegate{
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if global.YEARLY_HISTORY.count == 0 {
                performSegue(withIdentifier: "yDetails", sender: self)
                global.VIEW_INCOMPLETE = true
                return
            }
            
            global.VIEW_INCOMPLETE = false
            global.VIEW_SPENDING = String(global.YEARLY_HISTORY[indexPath.row])
            global.VIEW_DATE = String(global.YEARLY_DATE_HIST[indexPath.row])
            global.VIEW_LIMIT = String(global.YEARLY_HIST_GOAL[indexPath.row])
            global.VIEW_TIME = "year"
            if global.YEARLY_HIST_GOAL[indexPath.row] > global.YEARLY_HISTORY[indexPath.row]{
                global.VIEW_CONFIRM = true
            }
            else{global.VIEW_CONFIRM = false}
            performSegue(withIdentifier: "yDetails", sender: self)
            
        }
        
    }

    extension yearlyViewController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if global.YEARLY_HISTORY.count == 0 {return 1}
            return global.YEARLY_HISTORY.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //////want cell details to be date of that year
            let cell = tableView.dequeueReusableCell(withIdentifier: "yearlyCell") as! weeklyCell
            // might want default cell for empty
            if global.YEARLY_HISTORY.count == 0{
                cell.spendingLabel!.text = "Check back later!"
                cell.dateLabel.text = "----"
            }
            else{
                cell.spendingLabel.text = zero_check(num: "$" + String(global.YEARLY_HISTORY[indexPath.row]))
                
                cell.dateLabel.text = global.YEARLY_DATE_HIST[indexPath.row]
            }
            
            
            
            return cell
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    }
