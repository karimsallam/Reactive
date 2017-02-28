//
//  ReactiveInteractor.swift
//  DatePlay
//
//  Created by Karim Sallam on 11/12/2016.
//  Copyright © 2016 Karim Sallam. All rights reserved.
//

import Foundation
import ReactiveSwift

public protocol BaseReactiveInteractorProtocol: class {
    
    init()
}

open class BaseReactiveInteractor: BaseReactiveInteractorProtocol {
    
    public required init() {
        
    }
    
    deinit {
        debugPrint("\(NSStringFromClass(type(of: self))) deallocated")
    }
}

public protocol ReactiveInteractorProtocol: BaseReactiveInteractorProtocol {
}

open class ReactiveInteractor: BaseReactiveInteractor, ReactiveInteractorProtocol {
    
}
