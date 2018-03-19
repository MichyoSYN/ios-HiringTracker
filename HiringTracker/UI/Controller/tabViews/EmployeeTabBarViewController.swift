//
//  EmployeeTabBarViewController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/19/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit

class EmployeeTabBarViewController: UITabBarController {
    
    @IBOutlet weak var employeeTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarItems()
    }
    
    func setTabBarItems() {
        let items = employeeTabBar.items!
        let applicationsItem = items[0] as UITabBarItem
        IconHelper.setIconForBarItem(applicationsItem, iconName: .users)
        let meItem = items[1] as UITabBarItem
        IconHelper.setIconForBarItem(meItem, iconName: .userCircle)
    }
}
