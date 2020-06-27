//
//  Array+Identifiable.swift
//  Japanese Course Landing Page
//
//  Created by Antoine on 24/06/2020.
//  Copyright © 2020 BOUBERBOUCHE Antoine. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching element: Element) -> Int? {
        for index in indices {
            if self[index].id == element.id {
                return index
            }
        }
        return nil
    }
}
