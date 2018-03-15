//
//  AbstractSingleViewController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/1/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class AbstractSingleViewController: UITableViewController {
    var object: BasicObject?
    
    var aiHelper = ActivityIndicatorHelper()
    var needReloadData: Bool = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initActivityIndicators()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.reloadData()
    }
    
    // MARK: - Utility
    
    // Must be override by child controller
    internal func loadData() {
        // load List View data.
    }
    
    internal func reloadData() {
        object = nil
        loadData()
        self.tableView.reloadData()
    }
    
    // MARK: - UI
    
    fileprivate func initActivityIndicators() {
        aiHelper.addActivityIndicator(view)
    }
    
    // Refresh data invoked when pull down list
    @objc func refreshData() {
        self.reloadData()
        refreshControl?.endRefreshing()
    }
    
    // MARK: - Table view control
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
}
