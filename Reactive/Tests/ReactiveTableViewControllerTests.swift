//
//  ReactiveTableViewControllerTests.swift
//  Reactive
//
//  Created by Karim Sallam on 13/01/2017.
//  Copyright © 2017 Karim Sallam. All rights reserved.
//

import XCTest
import ReactiveSwift

class ReactiveTableViewControllerTests: XCTestCase {
    
    private var reactiveTableViewController: ReactiveTableViewController!
    
    override func setUp() {
        super.setUp()
        reactiveTableViewController = ReactiveTableViewController(style: .plain)
    }
    
    override func tearDown() {
        super.tearDown()
    }    
}
