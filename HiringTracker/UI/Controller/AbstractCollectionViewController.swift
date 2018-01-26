//
//  AbstractCollectionViewController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 1/25/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class AbstractCollectionViewController: UITableViewController, UISearchResultsUpdating {
    var objects = [BasicObject]()
    var filteredObjects = [BasicObject]()
    
    // Properties for search bar
    let searchController = UISearchController(searchResultsController: nil)
    
    // Properties for activity indicator
    var aiHelper = ActivityIndicatorHelper()
    var footAiHelper = ActivityIndicatorHelper()
    
    var needReloadData: Bool = false
    var page = 1
    var isLastPage = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchBar()
        initRefreshControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initActivityIndicators()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if needReloadData {
            self.reloadData()
        }
        self.setSearchBarOffset()
    }
    
    // MARK: - Utility
    
    // Must be override by child controller
    internal func loadData(_ page: NSInteger = 1) {
        // load List View data.
    }
    
    internal func reloadData() {
        page = 1
        if let footView = tableView.tableFooterView as? UILabel {
            footView.text = ""
        }
        clearAll()
        loadData()
        self.tableView.reloadData()
    }
    
    internal func loadNextPageData() {
        page = page + 1
        loadData(page)
    }
    
    // Clear all stored data
    internal func clearAll() {
        objects.removeAll()
        filteredObjects.removeAll()
    }
    
    // MARK: - UI
    
    // Set offset for tableView so that searchBar would not show on screen unless pull down list.
    internal func setSearchBarOffset() {
        if let searchBar = tableView.tableHeaderView {
            if tableView.contentOffset == CGPoint(x: 0, y: 0) {
                let searchBarHeight = searchBar.frame.size.height
                tableView.contentOffset = CGPoint(x: 0, y: searchBarHeight)
            }
        }
    }
    
    internal func setFootViewWithAi(_ footView: UIView) {
        footAiHelper.addActivityIndicator(footView)
        tableView.tableFooterView = footView
    }
    
    fileprivate func initActivityIndicators() {
        aiHelper.addActivityIndicator(view)
    }
    
    fileprivate func initSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    internal func initRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(AbstractCollectionViewController.refreshData), for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl
    }
    
    internal func isSearchActive() -> Bool {
        return searchController.isActive && searchController.searchBar.text != ""
    }
    
    // MARK: - Table view data source
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearchActive() {
            return filteredObjects.count
        }
        return objects.count
    }
    
    internal func getSelectedObject(_ indexPath: IndexPath) -> BasicObject {
        let object: BasicObject
        if self.isSearchActive() {
            object = self.filteredObjects[indexPath.row]
        } else {
            object = self.objects[indexPath.row]
        }
        return object
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ItemTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ItemTableViewCell
        
        let object = getSelectedObject(indexPath)
        cell.initCell(object)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let restObjects: [BasicObject]
        if isSearchActive() {
            restObjects = filteredObjects
        } else {
            restObjects = objects
        }
        let lastRow = restObjects.count - 1
        if indexPath.row == lastRow {
            if !isLastPage {
                if indexPath.row == lastRow {
                    self.loadNextPageData()
                }
            } else {
                setFootViewText(restObjects.count)
            }
        }
    }
    
    internal func setFootViewText(_ num: NSInteger) {
        if let label = tableView.tableFooterView as? UILabel {
            label.text = "- \(num) objects in total -"
        }
    }
    
    // Handle shift operation on single item
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.showAlert(indexPath, type: self.objects[indexPath.row].type(), name: self.objects[indexPath.row].name())
            tableView.setEditing(false, animated: false)
        }
        deleteAction.backgroundColor = UIColor.red
        return [deleteAction]
    }
    
    internal func showAlert(_ indexPath: IndexPath, type: String, name: String, message: String = "") {
        let showingMessage: String
        if message.isEmpty {
            showingMessage = "Are you sure to delete this \(type.lowercased()) named \(name)"
        } else {
            showingMessage = message
        }
        let alertController = UIAlertController(
            title: "Delete Warning",
            message: showingMessage,
            preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancle", style: .cancel) { (action: UIAlertAction!) in
            self.cancelDelete(indexPath)
        }
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.doDelete(indexPath)
        }
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    internal func doDelete(_ indexPath: IndexPath) {
        aiHelper.startActivityIndicator()
        let object = objects[indexPath.row] as BasicObject
        let objectFullName = "\(objects[indexPath.row].type()) \(objects[indexPath.row].objectName())"
        
        if object.getLink(.delete) != nil {
            let deletLink = object.getLink(.delete)!
            RestRequest.deleteWithAuth(deletLink) { result, error in
                if result {
                    printLog("Successfully delete \(objectFullName) from cloud.")
                    self.aiHelper.stopActivityIndicator()
                }
            }
        }
        
        printLog("Delete \(objectFullName) from list.")
        if !objects.isEmpty {
            objects.remove(at: indexPath.row)
        }
        setFootViewText(objects.count)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    fileprivate func cancelDelete(_ indexPath: IndexPath) {
        printLog("Cancel deletion.")
        self.tableView.cellForRow(at: indexPath)?.setEditing(false, animated: true)
    }
    
    // Refresh data invoked when pull down list
    @objc func refreshData() {
        self.reloadData()
        refreshControl?.endRefreshing()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowInfo" {
//            let infoViewController = segue.destination as! InfoViewController
//            let infoButton = sender as! UIButton
//            let view = infoButton.superview!
//            if let selectedItemCell = view.superview as? ItemTableViewCell {
//                let indexPath = tableView.indexPath(for: selectedItemCell)!
//                // path this information to cabinetviewcontroller
//                if isSearchActive() {
//                    infoViewController.object = filteredObjects[indexPath.row]
//                } else {
//                    infoViewController.object = objects[indexPath.row]
//                }
//            }
//        }
    }
    
    // MARK: - Search handling
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredObjects = objects.filter { object in
            return object.name().lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}

