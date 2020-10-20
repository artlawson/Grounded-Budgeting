//
//  settings.swift
//  Grounded
//
//  Created by artlawson on 7/2/20.
//  Copyright © 2020 artlawson. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {
    //wanna use this as a scroll for the different settings
    
    
    @IBOutlet  var settingsTable: UITableView!
    let settingsLabels = [
        "Change Weekly Reset Day", "Change Monthly Reset Day",
        "Set Spending Limits",
    ]
    //for cells to perform segue
    let cellDirections = ["weekly reset", "monthly reset", "set"]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTable.delegate = self
        settingsTable.dataSource = self
        let tableViewHeight = settingsTable.frame.height
        let contentHeight = settingsTable.contentSize.height

        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)

        settingsTable.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
        
}
class settingsCell: UITableViewCell {


    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            let newWidth = frame.width * 0.85 // get 80% width here
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space

            super.frame = frame

        }
    }

}

    
    extension settingsViewController: UITableViewDelegate{
        
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let row = indexPath.row
            performSegue(withIdentifier: cellDirections[row], sender: self)
            
        }
        
        
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            
            // this will turn on `masksToBounds` just before showing the cell
            cell.contentView.layer.masksToBounds = true
            
            // add this in `willDisplay` method
            let radius = cell.contentView.layer.cornerRadius
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
        }
        
    }

    extension settingsViewController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return settingsLabels.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //////want cell details to be date of that year
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell") as! settingsCell
            let row = indexPath.row
            cell.textLabel?.text = settingsLabels[row]
            //cell text color
            cell.textLabel?.textColor = UIColor .black
            cell.textLabel?.font = cell.textLabel?.font.withSize(20)
            
            cell.textLabel?.textAlignment = .center
            //adds shadow on cell
            cell.backgroundColor = .clear
            cell.layer.masksToBounds = false
            cell.layer.shadowOpacity = 0.23
            cell.layer.shadowRadius = 4
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.layer.shadowColor = UIColor.black.cgColor
            //color of cells
            cell.contentView.backgroundColor = .lightGray
            //UIColor(red:105/255,green: 190/255,blue: 40/255, alpha: 1.0)
            
            // add corner radius on `contentView`
            cell.contentView.layer.cornerRadius = 10
            
            return cell
        }
        
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    }

