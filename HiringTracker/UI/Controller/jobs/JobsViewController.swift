//
//  JobsViewController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/19/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class JobsViewController: AbstractCollectionViewController {

    @IBOutlet weak var footView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFootViewWithAi(footView)
        setSearchBarOffset()
        
        loadData()
    }
    
    // MARK: - Data
    override func loadData(_ page: NSInteger = 1) {
        super.loadData()
        
        let ai: ActivityIndicatorHelper
        if page == 1 {
            ai = aiHelper
        } else {
            ai = footAiHelper
        }
        ai.startActivityIndicator()
        
        let jobsService = JobsCollectionService(tail: "/repositories/REPO/jobs") // TODO: need to modify
        jobsService.getEntries(page, thisViewController: self) { (objects, isLastPage) in
            self.isLastPage = isLastPage
            self.objects = objects
            // set for ui
            self.view?.bringSubview(toFront: self.tableView)
            ai.stopActivityIndicator()
            
            DispatchQueue.main.async(execute: {
                () -> Void in
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showJobDetail" {
            let jobDetail = segue.destination as! JobDetailApplicantSideViewController
            if let selectedCell = sender as? JobsItemCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedItem = objects[indexPath.row]
                jobDetail.job = selectedItem as? Job
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobsItemCell", for: indexPath) as! JobsItemCell
        
        let job = objects[indexPath.row] as! Job
        cell.initCell(job: job)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}
