//
//  ApplicantTabBarViewController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/19/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class ApplicantTabBarViewController: UITabBarController {

    @IBOutlet weak var applicantTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarItems()
        
        login()
    }
    
    // TODO: this must be moved to login control controller
    func login() {
        AuthManager.setUserName("ann.takman")
        AuthManager.setPassword("password")
        
        let currentUserService = RestSingleService(url: Context.contextUrl() + "/repositories/REPO/current-applicant")
        currentUserService.getObject(thisViewController: self, aiHelper: nil) { applicant in
            let object = Applicant(object: applicant)
            Context.currentApplicant = object
        }
    }
    
    func setTabBarItems() {
        let items = applicantTabBar.items!
        let applicationsItem = items[0] as UITabBarItem
        IconHelper.setIconForBarItem(applicationsItem, iconName: .folder)
        let meItem = items[1] as UITabBarItem
        IconHelper.setIconForBarItem(meItem, iconName: .userCircle)
    }
}
