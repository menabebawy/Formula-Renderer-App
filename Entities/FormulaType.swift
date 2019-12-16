//
//  FormulaType.swift
//  Entities
//
//  Created by MacBook on 12/16/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

public struct FormulaType: Codable {
    let resourceLocation: String
}

extension FormulaType {
    enum CodingKeys: String, CodingKey {
        case resourceLocation = "x-resource-location"
    }

}
