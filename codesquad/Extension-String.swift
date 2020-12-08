//
//  Extension-String.swift
//  codesquad
//
//  Created by HOONHA CHOI on 2020/12/08.
//

import Foundation

extension String {
    subscript( int : Range<Int>) -> String {
        return String(self[index(startIndex, offsetBy: int.lowerBound)..<index(startIndex, offsetBy : int.upperBound)])
    }
}
