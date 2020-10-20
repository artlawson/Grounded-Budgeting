//
//  weeklyHist.swift
//  Grounded
//
//  Created by artlawson on 8/23/20.
//  Copyright © 2020 artlawson. All rights reserved.
//

import UIKit

class histViewController: UIViewController {

    @IBOutlet weak var spendingLabel: UILabel!
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var confirmLabel: UILabel!
    
    
    
override func viewDidLoad() {
    super.viewDidLoad()
    
        if global.VIEW_INCOMPLETE {
            spendingLabel.text = " "
            limitLabel.text = " "
            dateLabel.text = " Check back later!"
            confirmLabel.text = " "
            
            
        }
        else {
            spendingLabel.text = zero_check(num: "You spent $" + global.VIEW_SPENDING)
            limitLabel.text = zero_check(num: "Your limit was $" + global.VIEW_LIMIT)
            dateLabel.text = global.VIEW_DATE

            if global.VIEW_CONFIRM{
                confirmLabel.text = "Good Job staying under your limit this " + global.VIEW_TIME + "!"
            }
            else{
                confirmLabel.text = " "
            }

        }
    }
    
    
}

