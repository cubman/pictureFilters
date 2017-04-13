//
//  TableViewController.swift
//  improcessor
//
//  Created by student on 30.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var vcont : ViewController?
    var selectedIndex : IndexPath?
    var sets : [String : Any] = [:]
    var params : [UIView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vcont!.Filters.count
    }

    public func load(c : ViewController) {
        vcont = c
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        for subview in cell.stack.arrangedSubviews {
            //cell.stack.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        let note = vcont!.Filters[indexPath.row]
        let textl = UILabel()
        textl.text = note.getFilterName()
            
        //textLabel!.text = note.getFilterName()
        cell.stack.addArrangedSubview(textl)
        params = []
        if let c = selectedIndex, c == indexPath,
            let h = note.getCintrols(width: Int(tableView.bounds.width/2)) {
            for k in h {
                cell.stack.addArrangedSubview(k)
                params.insert(cell.stack.arrangedSubviews.last! , at: params.count)
            }
        }
        
        cell.backgroundColor = note.getColor()
        print(indexPath, cell.stack.arrangedSubviews.count)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let c = selectedIndex {
            
            if c == indexPath {
                return
            }
            let cell = tableView.cellForRow(at: c) as! TableViewCell
            for subview in cell.stack.arrangedSubviews {
                subview.removeFromSuperview()
            }

            selectedIndex = indexPath
            tableView.reloadRows(at: [c], with: .automatic)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            selectedIndex = indexPath
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Apply"
    }

    
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // tableView.reloadRows(at: [indexPath], with: .middle)

        if let c = selectedIndex, c == indexPath {
                let filter = vcont?.Filters[indexPath.row]
                return CGFloat((filter!.getSetting().getAmountOfSettings()  + 1 ) * 44 + 10)
            
        }
        return 34

    }
 
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vcont!.Filters[indexPath.row].setValue(values: params)
            vcont?.process(image: vcont!.imageView.image!, filterName: vcont!.Filters[indexPath.row])
            navigationController!.popToRootViewController(animated: true)

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
