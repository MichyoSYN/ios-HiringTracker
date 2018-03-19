//
//  Job.swift
//  HiringTracker
//
//  Created by Song, Michyo on 1/24/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import SwiftyRest

class Job: Document {
    static let dmType = DmType.dmDocument
    
    var importancy: Importancy = .D
    
    override init(object: RestObject) {
        super.init(object: object)
        self.importancy = .D
    }
    
    init(object: RestObject, importancy: Importancy) {
        super.init(object: object)
        self.importancy = importancy
    }
    
    func getDivision() -> String {
        let division = self.getProperties().value(forKey: "title")
        if division != nil && !(String(describing: division!).isEmpty) {
            return String(describing: division!)
        } else {
            return "OpenText"
        }
    }
    
    func getJobId() -> String {
        let id = self.getProperties().value(forKey: "r_object_id")
        return id! as! String
    }
    
    func getJobContentLink() -> String {
        return getLink(.content)!
    }
}

enum Importancy {
    case A
    case B
    case C
    case D
}
