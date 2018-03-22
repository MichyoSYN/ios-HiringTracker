//
//  Applicant.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/1/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import SwiftyRest

class Applicant: Document {
    var username: String = ""
    var loginId: String = ""
    var appliedJobId: String?
    
    override init(object: RestObject) {
        let rawDic = object.getRawDictionary()
        let userNameKey = ApplicantProperties.username.rawValue
        let loginIdKey = ApplicantProperties.loginid.rawValue
        if let name = rawDic.value(forKey: userNameKey) {
            self.username = name as! String
        }
        if let id = rawDic.value(forKey: loginIdKey) {
            self.loginId = id as! String
        }
        super.init(object: object)
    }
    
    func getAppliedJobId() -> String? {
        return appliedJobId
    }
    
    func setAppliedJobId(id: String) {
        appliedJobId = id
    }
}
