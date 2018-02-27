//
//  MainMenuViewController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 2/26/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit

class MainMenuViewController: UITableViewController {

//    var applicantsViewController: ApplicantsViewController? = nil
    
    override func viewDidLoad() {
//        if let split = splitViewController {
//            let controllers = split.viewControllers
//            applicantsViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ApplicantsViewController
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

//        if segue.identifier == "showApplicants" {
//            self.navigationController?.pushViewController(applicantsViewController!, animated: true)
//        }
    }

}
