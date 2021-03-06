//
//  AbilityWizard4d6TableViewController.swift
//  iOS
//
//  Created by Syd Polk on 7/13/18.
//  Copyright © 2018 Bone Jarring Games and Software. All rights reserved.
//

import UIKit

class AbilityWizard4d6TableViewController: UITableViewController {

    var rolls: [Rolls4d6]? = nil
    var delegate: Wizard4d6ViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isEditing = true
        self.tableView.isScrollEnabled = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Ability4d6Cell", for: indexPath) as! AbilityWizard4d6TableViewCell

        // Configure the cell...

        if let rolls = self.rolls {
            cell.setGUI(rolls: rolls[indexPath.row].rolls)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        print("Moving row from %d to %d", fromIndexPath.row, to.row)
        if var rolls = self.rolls {
            let abilityRolls = rolls[fromIndexPath.row]
            rolls[fromIndexPath.row] = rolls[to.row]
            rolls[to.row] = abilityRolls
            if let delegate = self.delegate {
                delegate.setRolls(withRolls: rolls)
            }
            self.tableView.reloadData()
        }
        
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func setRolls(rolls: [Rolls4d6]) {
        self.rolls = rolls
        self.tableView.reloadData()
    }

    func setDelegate(delegate: Wizard4d6ViewControllerDelegate) {
        self.delegate = delegate
    }
}
