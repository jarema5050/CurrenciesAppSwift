//
//  Selectable.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 21/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import Foundation

protocol Selectable {
    func changeDataSource(endpoint: Endpoints)
    func chooseCurrency(code: String)
}
