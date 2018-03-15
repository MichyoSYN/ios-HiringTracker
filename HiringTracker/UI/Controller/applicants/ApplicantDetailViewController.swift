//
//  ApplicantDetailViewController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 1/24/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class ApplicantDetailViewController: AbstractSingleViewController {
    
    var applicantUrl: String?    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    // MARK: - Data
    override func loadData() {
        super.loadData()
        
        aiHelper.startActivityIndicator()
        
        // TODO: delete after finish login && delete import SwiftyRest
        AuthManager.setUserName("Administrator")
        AuthManager.setPassword("password")
        //
        
        let applicantService = RestSingleService(url: applicantUrl!)
        applicantService.getObject(thisViewController: self, params: ["view": ":all"]) { object in
            self.object = Applicant(object: object)
            // set for ui
            self.view?.bringSubview(toFront: self.tableView)
            self.aiHelper.stopActivityIndicator()
            DispatchQueue.main.async(execute: {
                () -> Void in
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: - Table view control
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // TODO, need modify if any appending
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if let applicant = object as? Applicant {
                return ApplicantDetailInfoCell.keys.count
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! ApplicantDetailTitleCell
            if let applicant = object as? Applicant {
                cell.initCell(applicant: applicant)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! ApplicantDetailInfoCell
            if let applicant = object as? Applicant {
                cell.initCell(applicant: applicant, indexPath: indexPath)
            }
            return cell
        default:
            return UITableViewCell.init()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        
        switch section {
        case 0:
            return 100
        default:
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}

