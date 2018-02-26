//
//  UserCollectionService.swift
//  HiringTracker
//
//  Created by Song, Michyo on 1/26/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class UserCollectionService: RestCollectionService {
    
    override func getService(_ pageNo: NSInteger, completionHandler: @escaping (Array<RestObject>?, RestError?) -> ()) {
        super.getService(pageNo, completionHandler: completionHandler)
        RestRequest.getRestObjectCollection(self.url!, params: self.getParams(pageNo), completionHandler: completionHandler)
    }
    
    override func constructRestObject(_ object: RestObject) -> BasicObject {
        let restObject: BasicObject
        restObject = User(object: object)
        return restObject
    }
}

