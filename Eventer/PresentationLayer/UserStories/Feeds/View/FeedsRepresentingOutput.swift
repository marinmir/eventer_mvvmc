//
//  FeedsRepresentingOutput.swift
//  Eventer
//
//  Created by Мирошниченко Марина on 03.09.2020.
//  Copyright © 2020 Мирошниченко Марина. All rights reserved.
//

import UIKit

protocol FeedsRepresentingOutput: AnyObject, UITableViewDataSource & UITableViewDelegate {
    func onRefresh()
}
