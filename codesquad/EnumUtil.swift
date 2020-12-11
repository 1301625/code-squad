//
//  EnumUtil.swift
//  codesquad
//
//  Created by HOONHA CHOI on 2020/12/11.
//

import Foundation

enum Action : String {
    case U, L, F, R, B, D
    case Usquoted = "U'"
    case Lsquoted = "L'"
    case Fsquoted = "F'"
    case Rsquoted = "R'"
    case Bsquoted = "B'"
    case Dsquoted = "D'"
    
    func toString() -> String {
        switch self {
        case .Usquoted : return "U'"
        case .Lsquoted : return "L'"
        case .Fsquoted : return "F'"
        case .Rsquoted : return "R'"
        case .Bsquoted : return "B'"
        case .Dsquoted : return "D'"
        default:
            return self.rawValue
        }
    }
}

enum Color : String {
    case B,W,O,G,Y,R
    
    init(num : Int) {
        switch num {
        case 0:
            self = .B
        case 1:
            self = .W
        case 2:
            self = .O
        case 3:
            self = .G
        case 4:
            self = .Y
        default:
            self = .R
        }
    }
}
