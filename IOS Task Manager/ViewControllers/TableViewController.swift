//
//  TableViewController.swift
//  IOS Task Manager
//
//  Created by Miranda Jessie on 11/30/18.
//  Copyright © 2018 Miranda Jessie. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let array = tasksArray.sharedInstance

    override func  viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.emptyDataSetSource = self as? DZNEmptyDataSetSource;
        self.tableView.emptyDataSetDelegate = self as? DZNEmptyDataSetDelegate;
        
        //Removing the cell separators
        tableView.tableFooterView = UIView()
        
        tableView.reloadData()
}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
}
    //Transfering the task info from library screen to Task Info screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTaskInfo" {
            
            let indexPath = self.tableView!.indexPathsForSelectedRows!.first!
            let task = array.tasks[indexPath.row]
            let vc = segue.destination as! TaskDetailsController
            vc.details = task.taskDetails
            vc.name = task.taskName
        }
    }
}



//Creates table view
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.tasks.count
    }
    //Creating a new cell based on info added
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! taskCell
        
        let task = array.tasks[indexPath.row]
        cell.setup(task: task)
        
        return cell

}
    //Marking task as incomplete
    func incomplete(at indexPath: IndexPath) {
        let task = self.array.tasks[indexPath.row]
        
        let calendar = Calendar(identifier: .gregorian)
        let dueDate = calendar.date(byAdding: .day, value: 7, to: Date())!
        
        task.completion = .incomplete(dueDate: dueDate)
        (tableView.cellForRow(at: indexPath) as! taskCell).setup(task: task)
}
    //Marking task as complete
    func complete(at indexPath: IndexPath) {
        let task = self.array.tasks[indexPath.row]
        task.completion = .complete
        (tableView.cellForRow(at: indexPath) as! taskCell).setup(task: task)
        
}
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Deleting Tasks
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            tasksArray.sharedInstance.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
}

        let task = array.tasks[indexPath.row]

        //Adding the ability to swipe left on a cell to mark it as completed/incomplete or delete it
        switch task.completion {
        case .complete:
            let markIncompleteAction = UITableViewRowAction(style: .normal, title: "Incomplete?") { _, indexPath in
                
                self.incomplete(at: indexPath)
                
            }
            
            return [deleteAction, markIncompleteAction]
            
        case .incomplete:
            let markCompleteAction = UITableViewRowAction(style: .normal, title: "Finished?") { _, indexPath in
                self.complete(at: indexPath)
            }
            
            return [deleteAction, markCompleteAction]
        }
    }
}
