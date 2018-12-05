//
//  AddTaskController.swift
//  IOS Task Manager
//
//  Created by Miranda Jessie on 11/27/18.
//  Copyright © 2018 Miranda Jessie. All rights reserved.
//

import UIKit

class addTaskController: UIViewController {
    
    //IBOutlets:
    @IBOutlet weak var taskNameTF: UITextField!
    @IBOutlet weak var detailsTV: UITextView!
    @IBOutlet weak var prioritySC: UISegmentedControl!
    
    //IBAction:
    @IBAction func saveTaskTapped(_ sender: Any){
        guard
        let title = taskNameTF.text, !title.isEmpty,
        let details = detailsTV.text, !details.isEmpty
            else {
                let errorAlert = UIAlertController(title: "Error", message: "Make sure everything is filled out", preferredStyle: .alert)
                let errorAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) //When tapped this will dismiss the error alert
                errorAlert.addAction(errorAction)
                self.present(errorAlert, animated: true, completion: nil)
                return
        }
        //SaveTask function will go here
        saveTask()
    }
    //Shows options for priority
    let segments: [(title: String, priority: Task.Priority)] =
          [("Yes", .priority),
           ("No", .notPriority)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        
        //This removes the keyboard when the user taps somewhere else on the screen
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        prioritySC.removeAllSegments()
        
        for (index, segment) in segments.enumerated() {
            prioritySC.insertSegment(withTitle: segment.title, at: index, animated: false)
        }
        prioritySC.selectedSegmentIndex = 0;

    }
    func saveTask() {
        //Title
        guard let title = taskNameTF.text else { return
        }
        
        //Details
        guard let taskDetails = detailsTV.text else { return
        }
        //Priority
        let priority = segments[prioritySC.selectedSegmentIndex].priority
        let task = Task(taskName: title, taskDetails: taskDetails, priority: priority)
        
        //Adds the new task to the array
        tasksArray.sharedInstance.tasks.append(task)
        self.navigationController?.popViewController(animated: true)

    }
}
