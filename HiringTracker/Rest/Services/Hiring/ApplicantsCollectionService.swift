//
//  ApplicantsCollectionService.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/1/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class ApplicantsCollectionService: UserCollectionService {
    override func getService(_ pageNo: NSInteger, completionHandler: @escaping (Array<RestObject>?, RestError?) -> ()) {
        super.getService(pageNo, completionHandler: completionHandler)
        var params = self.getParams(pageNo)
        params["view"] = ":all"
        RestRequest.getRestObjectCollection(self.url!, params: params, completionHandler: completionHandler)
    }
    
    override func constructRestObject(_ object: RestObject) -> BasicObject {
        let restObject: BasicObject
        restObject = Applicant(object: object)
        return restObject
    }
}
