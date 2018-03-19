//
//  ApplicantTabBarViewController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/19/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit

class ApplicantTabBarViewController: UITabBarController {

    @IBOutlet weak var applicantTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarItems()
    }
    
    func setTabBarItems() {
        let items = applicantTabBar.items!
        let applicationsItem = items[0] as UITabBarItem
        IconHelper.setIconForBarItem(applicationsItem, iconName: .folder)
        let meItem = items[1] as UITabBarItem
        IconHelper.setIconForBarItem(meItem, iconName: .userCircle)
    }
}
