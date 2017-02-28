//
//  ReactiveInteractor.swift
//  DatePlay
//
//  Created by Karim Sallam on 11/12/2016.
//  Copyright © 2016 Karim Sallam. All rights reserved.
//

import Foundation
import ReactiveSwift

public protocol ReactiveInteractorProtocol: class {
    
    init()
}

open class ReactiveInteractor {
    
    public required init() {
        
    }
}

extension ReactiveInteractor: ReactiveInteractorProtocol {
    
}
