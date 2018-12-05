//
//  TaskDetailsController.swift
//  IOS Task Manager
//
//  Created by Miranda Jessie on 12/3/18.
//  Copyright © 2018 Miranda Jessie. All rights reserved.
//

import UIKit

class TaskDetailsController: UIViewController {
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var detailsLabel: UITextView!
    
    
    var details = String()
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        taskName.text = name
        detailsLabel.text = details
    }
    
}
