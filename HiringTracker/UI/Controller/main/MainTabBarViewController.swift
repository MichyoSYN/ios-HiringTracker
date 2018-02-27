//
//  MainTabBarViewController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 2/27/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    @IBOutlet weak var mainTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarItems()
    }
    
    func setTabBarItems() {
        let items = mainTabBar.items!
        let applicationsItem = items[0] as UITabBarItem
        IconHelper.setIconForBarItem(applicationsItem, iconName: .users)
        let meItem = items[1] as UITabBarItem
        IconHelper.setIconForBarItem(meItem, iconName: .userCircle)
    }
}
