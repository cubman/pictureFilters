//
//  tableViewDelegate.swift
//  improcessor
//
//  Created by student on 12.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

class tableViewDelegate: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
   
    override func tableView( tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "More", handler:{action, indexpath in
            print("MORE•ACTION");
        });
        moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete", handler:{action, indexpath in
            print("DELETE•ACTION");
        });
        
        return [deleteRowAction, moreRowAction];
    }
}
