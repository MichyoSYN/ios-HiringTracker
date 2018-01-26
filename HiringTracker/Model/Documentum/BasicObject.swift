//
//  BasicObject.swift
//  HiringTracker
//
//  Created by Song, Michyo on 1/24/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

public class BasicObject: RestObject {
    static let defaultLocale = "en_US_POSIX"
    
    var linkToGet: String = ""
    
    // MARK: initialization
    
    init(object: RestObject) {
        super.init(entry: object.getRawDictionary())
        getLinkToGet()
    }
    
    fileprivate func getLinkToGet() {
        if let selfLink = getLink(.selfRel) {
            linkToGet = selfLink
        } else if let editLink = getLink(.edit) {
            linkToGet = editLink
        } else {
            linkToGet = ""
        }
    }
    
    // MARK: getter
    
    func name() -> String {
        if let objectName = objectName() {
            return objectName
        } else if let userName = userName() {
            return userName
        } else {
            return ""
        }
    }
    
    func objectName() -> String? {
        return getProperty(.OBJECT_NAME) as? String
    }
    
    func userName() -> String? {
        return getProperty(.USER_NAME) as? String
    }
    
    func type() -> String {
        return getProperty(.TYPE) as! String
    }
    
    func getProperty(_ propertyName: ObjectProperties) -> AnyObject? {
        return getProperty(propertyName.rawValue)
    }
    
    
}
