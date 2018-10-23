//
//  TrashTableViewController.swift
//  ComeApp
//
//  Created by kobi on 27/08/2017.
//  Copyright © 2017 Kobi Kanetti. All rights reserved.
//

import UIKit
import CoreData

class TrashTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableArray : [Item] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard DBManager.manager.didRegister == false else {
            loadData()
            return
        }
        
        let alert = UIAlertController(title: "SignIn", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { (_) in
            
            guard let name = alert.textFields?.first?.text, !name.isEmpty else{
                 return
            }
            
            DBManager.manager.signUp(with: name, callBack: { (error) in
                if error != nil{
                    return
                    // Toast
                } else {
                    self.loadData()
                }
            })
            
        }))
        
        alert.addTextField{
            $0.placeholder = "Enter name"
        }
        
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func loadData(){
        navigationItem.title = DBManager.manager.userName
        
        DBManager.manager.observeAllItems {
            self.tableArray = $0
            self.tableView.reloadData()
        }
    }
    
    // back button
    @IBAction func unwindToRoot(_ segue : UIStoryboardSegue){
        
    }
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!TrashCell

        // Configure the cell...
        
        let i : Item = tableArray[indexPath.row]
        cell.configure(with: i)

        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let nextVC = segue.destination as? ItemViewController
            , segue.identifier == "detailsSegue",
            let indexPath = tableView.indexPathForSelectedRow{
            
            nextVC.item = tableArray[indexPath.row]
            
        }
        
    }
    

}
