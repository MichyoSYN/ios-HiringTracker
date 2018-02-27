//
//  AbstractSplitViewController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 2/26/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit

class AbstractSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredDisplayMode = .allVisible
    }
}
