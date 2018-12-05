//
//  taskCell.swift
//  IOS Task Manager
//
//  Created by Miranda Jessie on 12/3/18.
//  Copyright © 2018 Miranda Jessie. All rights reserved.
//

import UIKit

class taskCell: UITableViewCell {
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var completionView: UIView!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setup(task: Task) {
        taskNameLabel.text = task.taskName
        
        //Priority being set based on what the user chooses - using the raw value to save time
        priorityLabel.text = task.priority.rawValue
        
        switch task.completion {
        case .complete:
            //This hides the due date
            dueDateLabel.isHidden = true
            
            //Set view to green
            completionView.backgroundColor = .green
            
        case .incomplete(let date):
            //show due date
            dueDateLabel.isHidden = false
            //set view to red
            completionView.backgroundColor = .red
            //set dueDate to formatted date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dueDateLabel.text = dateFormatter.string(from: date)
        }
    }   
}
