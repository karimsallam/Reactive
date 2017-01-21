//
//  Module.swift
//  Reactive
//
//  Created by Karim Sallam on 21/01/2017.
//  Copyright © 2017 Karim Sallam. All rights reserved.
//

import Foundation

open class ReactiveModule: NSObject {
    
//    let a: AnyClass
    
    let reactiveController: ReactiveController
    
    public override init() {
        reactiveController = ReactiveController()
    }
    
    deinit {
        debugPrint("\(NSStringFromClass(type(of: self))) deallocated")
    }
}

extension ReactiveModule: UseCase {
    
}
