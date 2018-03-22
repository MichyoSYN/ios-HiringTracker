//
//  LoginController.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/22/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class LoginController: UIViewController {
    
    override func viewDidLoad() {
        login()
    }
    
    // TODO: this must be moved to login control controller
    func login() {
        AuthManager.setUserName("ann.takman")
        AuthManager.setPassword("password")
        
        let currentUserService = RestSingleService(url: Context.contextUrl() + "/repositories/REPO/current-applicant") // TODO: modify
        currentUserService.getObject(thisViewController: self, aiHelper: nil) { applicant in
            let object = Applicant(object: applicant)
            let currentVersionUrl = object.getLink("http://identifiers.emc.com/linkrel/current-version")!
            UtilService.getSingleParamFromResponse(url: currentVersionUrl, key: "properties", thisViewController: self, completionHandler: { dic in
                let dic = dic as! NSDictionary
                let keywords = dic.value(forKey: "keywords") as! [String]
                let lastAppliedJobId = keywords[keywords.count - 1]
                object.setAppliedJobId(id: lastAppliedJobId)
                Context.currentApplicant = object
                print("Current user \(object.name()) last applied job id is \(lastAppliedJobId)")
            })
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
            print("Login as \(String(Context.currentApplicant!.name()))")
        }
    }
    
}
