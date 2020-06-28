//
//  Array+Only.swift
//  Japanese Course Landing Page
//
//  Created by Antoine on 24/06/2020.
//  Copyright © 2020 BOUBERBOUCHE Antoine. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
