//
//  ApplicantsViewController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 1/24/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class ApplicantsViewController: AbstractCollectionViewController {
    @IBOutlet weak var footView: UILabel!
    
    var detailViewController: ApplicantDetailViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        
        setFootViewWithAi(footView)
        setSearchBarOffset()

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        loadData()
    }

    @objc
    func insertNewObject(_ sender: Any) {
//        objects.insert(NSDate(), at: 0)
//        let indexPath = IndexPath(row: 0, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
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
        
        // TODO: delete after finish login && delete import SwiftyRest
        AuthManager.setUserName("Administrator")
        AuthManager.setPassword("password")
        //
        
        let applicantsService = ApplicantsCollectionService(tail: "/repositories/REPO/applicants") // TODO: need to modify
        applicantsService.getEntries(page, thisViewController: self) { (objects, isLastPage) in
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

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showApplicantDetail" {
            let applicantDetailViewController = segue.destination as! ApplicantDetailViewController
            if let selectedCell = sender as? ApplicantsItemCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedItem = objects[indexPath.row]
                applicantDetailViewController.needReloadData = true
                applicantDetailViewController.applicantUrl = selectedItem.linkToGet
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicantItemCell", for: indexPath) as! ApplicantsItemCell
        
        let applicant = objects[indexPath.row] as! Applicant
        cell.initCell(applicant: applicant)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

