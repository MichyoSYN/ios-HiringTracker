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
    
    init(object: RestObject, importancy: Importancy) {
        super.init(object: object)
        self.importancy = importancy
    }
}

enum Importancy {
    case A
    case B
    case C
    case D
}
