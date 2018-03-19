//
//  JobDetailApplicantSideViewController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/19/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class JobDetailApplicantSideViewController: UIViewController {
    @IBOutlet weak var divisionLabel: UILabel!
    @IBOutlet weak var jobIdLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobDescriptionTextView: UITextView!
    
    var job: Job?
    let aiHelper = ActivityIndicatorHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aiHelper.addActivityIndicator(jobDescriptionTextView)
        aiHelper.startActivityIndicator()
        
        if let job = job {
            divisionLabel.text = job.getDivision()
            jobIdLabel.text = job.getJobId()
            jobTitleLabel.text = job.name()
            jobDescriptionTextView.text = ""
        }
        
        getJobDescription()
    }
    
    func getJobDescription() {
        if job != nil {
            if FileUtility.isDownloaded(job!.getJobId()) {
                loadFileFromLocal(job!.getJobId())
            } else {
                let primaryContentLink = self.job!.getJobContentLink()
                RestDownloadService.download(primaryContentLink, doAfterDownloaded: self.downloadFileFromUrl)
            }
        }
    }
    
    func loadFileFromLocal(_ objectId: String) {
        DispatchQueue.main.async(execute: {
            () -> Void in
            let fileUrl = FileUtility.getFileUrlFromId(objectId)
            let text = String(data: try! Data(contentsOf: fileUrl), encoding: .utf8)
            self.jobDescriptionTextView.text = text
            self.aiHelper.stopActivityIndicator()
        })
    }
    
    fileprivate func downloadFileFromUrl(_ url: String) {
        RestRequest.downloadFile(url, objectId: self.job!.getJobId()) { data, error in
            if let e = error {
                ErrorAlert.show(e.getMessage(), controller: self)
                return
            }
            if let d = data {
                // set picture to a new one
                DispatchQueue.main.async(execute: {
                    let text = String(data: d, encoding: .utf8)
                    self.jobDescriptionTextView.text = text
                    self.aiHelper.stopActivityIndicator()
                })
            }
        }
    }
}
