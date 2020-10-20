//
//  storage.swift
//  Grounded
//
//  Created by artlawson on 6/15/20.
//  Copyright © 2020 artlawson. All rights reserved.
//

import Foundation
import UIKit


//consider moving all extensions to this file
class Global{
    //current spendings
    var WEEKLY_CURRENT: Double = 0.00
    var MONTHLY_CURRENT: Double = 0.00
    var YEARLY_CURRENT: Double = 0.00
    //spending limits
    var WEEKLY_LIMIT: Double = 50.00
    var MONTHLY_LIMIT: Double = 318.00
    var YEARLY_LIMIT: Double = 5000.00
    //spending histories
    var WEEKLY_HISTORY: Array<Double> = [4.20, 3.18, 17.38]
    var MONTHLY_HISTORY: Array<Double> = [12.23]
    var YEARLY_HISTORY: Array<Double> = []
    //goal for each
    var WEEKLY_HIST_GOAL: Array<Double> = [50.00,50.00,50.00]
    var MONTHLY_HIST_GOAL: Array<Double> = [318]
    var YEARLY_HIST_GOAL: Array<Double> = []
    //dates for each
    var WEEKLY_DATE_HIST: Array<String> = [ "7-15-2015","7-22-2015", "7-29-15"]
    var MONTHLY_DATE_HIST: Array<String> = ["August 2020"]
    var YEARLY_DATE_HIST: Array<String> = []
    //what day they reset
    var WEEK_RESET = 2 //2 is Monday
    var MONTH_RESET = "01"
    var YEAR_RESET = "JANUARY 1ST"
    //keeps track of currents
    var CURRENT_DATE = "DECEMBER 30TH, 2020"
    var MONTH_DAY = "01"
    var CURRENT_MONTH = "December"
    var CURRENT_YEAR = "1999"
    
    
    // the last start day
    var WEEK_START = "7-15-2015"
    var MONTH_START = "8-20-17"
    var YEAR_START = "2-14-20"
    
    //vars for temp view
    var VIEW_SPENDING = " "
    var VIEW_LIMIT = " "
    var VIEW_DATE = " "
    var VIEW_TIME = " "
    //chekck if limit was respected
    var VIEW_CONFIRM = false
    //if the current attempting view has no history
    var VIEW_INCOMPLETE = false
    

    //array for quotes for lock screen?
    
    
    //consider making new array for goals
    //can do successes vs failures as arr of booleans
    
    
    ///weekly.swift sets global current date
  

}

var global = Global()
