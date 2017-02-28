//
//  ReactivePresenter.swift
//  Reactive
//
//  Created by Karim Sallam on 28/02/2017.
//  Copyright © 2017 Karim Sallam. All rights reserved.
//

import Foundation
import ReactiveSwift

public protocol ReactivePresenterProtocol: class {
    
    init()
    
    weak var reactiveInteractorProtocol: ReactiveInteractorProtocol? { get set }

    weak var reactiveWireframeProtocol: ReactiveWireframeProtocol? { get set }

    var reactiveUserInterfaces: [ReactiveUserInterface] { get }

    func add(reactiveUserInterface: ReactiveUserInterface)

    func remove(reactiveUserInterface: ReactiveUserInterface)
}

open class ReactivePresenter<ReactiveInteractor: ReactiveInteractorProtocol, ReactiveWireframe: ReactiveWireframeProtocol> {
    
    public required init() {
        
    }

    public weak var reactiveInteractor: ReactiveInteractor?

    public weak var reactiveWireframe: ReactiveWireframe?
    
    internal(set) public var reactiveUserInterfaces = [ReactiveUserInterface]()
    
    internal func observe(reactiveUserInterface: ReactiveUserInterface) {
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

extension ReactivePresenter: ReactivePresenterProtocol {
    
    public weak var reactiveInteractorProtocol: ReactiveInteractorProtocol? {
        get {
            return reactiveInteractor
        }
        set {
            reactiveInteractor = newValue as? ReactiveInteractor
        }
    }

    public weak var reactiveWireframeProtocol: ReactiveWireframeProtocol? {
        get {
            return reactiveWireframe
        }
        set {
            reactiveWireframe = newValue as? ReactiveWireframe
        }
    }

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
}
