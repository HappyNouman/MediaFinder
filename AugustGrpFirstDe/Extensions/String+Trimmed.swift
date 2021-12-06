//
//  string+trimmed.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 10/30/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import Foundation

extension String {
    var trimmed: String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
