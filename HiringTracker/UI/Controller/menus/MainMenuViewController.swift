//
//  MainMenuViewController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 2/26/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit

class MainMenuViewController: UITableViewController {
    
    var applicantsViewController: ApplicantsViewController? = nil
    
    override func viewDidLoad() {
        if let split = splitViewController {
            let controllers = split.viewControllers
            applicantsViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ApplicantsViewController
        }
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showApplicants" {
            //            if let indexPath = tableView.indexPathForSelectedRow {
            //                let object = objects[indexPath.row] as BasicObject
            //                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            //                controller.detailItem = object
            //                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            //                controller.navigationItem.leftItemsSupplementBackButton = true
            //            }
        }
    }

}
