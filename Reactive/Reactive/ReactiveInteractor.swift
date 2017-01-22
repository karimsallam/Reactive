//
//  ReactiveInteractor.swift
//  DatePlay
//
//  Created by Karim Sallam on 11/12/2016.
//  Copyright © 2016 Karim Sallam. All rights reserved.
//

import Foundation
import ReactiveSwift

open class ReactiveInteractor: NSObject {
    
    private(set) var reactiveUserInterfaces = [ReactiveUserInterface]()
    
    public func add(reactiveUserInterface: ReactiveUserInterface) {
        reactiveUserInterfaces.append(reactiveUserInterface)
        observe(reactiveUserInterface: reactiveUserInterface)
    }
    
    public func remove(reactiveUserInterface: ReactiveUserInterface) {
        guard let index = reactiveUserInterfaces.index(where: { $0 == reactiveUserInterface }) else {
            fatalError("\(reactiveUserInterface) not found")
        }
        reactiveUserInterfaces.remove(at: index)
    }
    
    private func observe(reactiveUserInterface: ReactiveUserInterface) {
        reactiveUserInterface.reactiveState.producer.startWithSignal { observer, disposable in
            observer.observeValues{ [weak self] reactiveState in
                if reactiveState == .ready {
                    self?.bind(reactiveUserInterface: reactiveUserInterface)
                    disposable.dispose()
                }
            }
        }
    }
    
    open func bind(reactiveUserInterface: ReactiveUserInterface) {
        // Do nothing.
    }
    
    deinit {
        debugPrint("\(NSStringFromClass(type(of: self))) deallocated")
    }
}
