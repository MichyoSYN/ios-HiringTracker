//
//  JobsCollectionService.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/19/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class JobsCollectionService: RestCollectionService {
    override func getService(_ pageNo: NSInteger, completionHandler: @escaping (Array<RestObject>?, RestError?) -> ()) {
        super.getService(pageNo, completionHandler: completionHandler)
        RestRequest.getRestObjectCollection(self.url!, params: self.getParams(pageNo),completionHandler: completionHandler)
    }
    
    override func constructRestObject(_ object: RestObject) -> BasicObject {
        let restObject: BasicObject
        restObject = Job(object: object)
        return restObject
    }
}
