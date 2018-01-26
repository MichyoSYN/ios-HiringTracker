//
//  User.swift
//  HiringTracker
//
//  Created by Song, Michyo on 1/25/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import SwiftyRest

class User : BasicObject {
    
    let userPrivilegesTable: [UserPrivilege] = [
        .none, .create_TYPE, .create_CABINET, .create_GROUP, .sysadmin, .superuser
    ]
    
    func getReadableUSerPrivilege() -> String {
        return getReadableUserPrivilege(getProperty(.USER_PRIVILEGES) as! Int)
    }
    
    fileprivate func getReadableUserPrivilege(_ userPrivilege: Int) -> String {
        if userPrivilege == 0 {
            return userPrivilegesTable[0].readablePrivilege()
        }
        let binary = String(userPrivilege, radix: 2)
        let length = binary.count
        if length > 4 {
            return userPrivilegesTable[5].readablePrivilege()
        } else if length == 4 {
            return userPrivilegesTable[4].readablePrivilege()
        } else if length == 3 {
            switch binary {
            case "100":
                return userPrivilegesTable[3].readablePrivilege()
            case "101":
                return "Create Group and Type"
            case "110":
                return "Create Group and Cabinet"
            case "111":
                return "Create Group, Cabinet and Type"
            default:
                break
            }
        } else if length == 2 {
            switch binary {
            case "10":
                return userPrivilegesTable[2].readablePrivilege()
            case "11":
                return "Create Cabinet and Type"
            default:
                break
            }
        } else if length == 1{
            return userPrivilegesTable[1].readablePrivilege()
        }
        return ""
    }
}

enum UserPrivilege : Int {
    case none = 0
    case create_TYPE = 1
    case create_CABINET = 2
    case create_GROUP = 4
    case sysadmin = 8
    case superuser = 16
    
    func readablePrivilege() -> String {
        switch self {
        case .none:
            return "None"
        case .create_TYPE:
            return "Create Type"
        case .create_CABINET:
            return "Create Cabinet"
        case .create_GROUP:
            return "Create Group"
        case .sysadmin:
            return "System Administrator"
        case .superuser:
            return "Super User"
        }
    }
}
