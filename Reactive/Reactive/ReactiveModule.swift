//
//  Module.swift
//  Reactive
//
//  Created by Karim Sallam on 21/01/2017.
//  Copyright © 2017 Karim Sallam. All rights reserved.
//

import UIKit

open class ReactiveModule<ReactiveInteractor: ReactiveInteractorProtocol, ReactivePresenter: ReactivePresenterProtocol, ReactiveWireframe: ReactiveWireframeProtocol> {
    
    public let reactiveInteractor: ReactiveInteractor
    
    public let reactivePresenter: ReactivePresenter
    
    public let reactiveWireframe: ReactiveWireframe
    
    public init(presentingViewController: UIViewController) {
        reactiveInteractor = ReactiveInteractor()
        reactivePresenter = ReactivePresenter()
        reactiveWireframe = ReactiveWireframe(presentingViewController: presentingViewController)
        
        reactivePresenter.reactiveInteractorProtocol = reactiveInteractor
        reactivePresenter.reactiveWireframeProtocol = reactiveWireframe
        reactiveWireframe.reactivePresenterProtocol = reactivePresenter
    }
    
    deinit {
        debugPrint("\(NSStringFromClass(type(of: self))) deallocated")
    }
}

extension ReactiveModule: UseCase {
    
    public var presentingViewController : UIViewController {
        return reactiveWireframe.presentingViewController
    }
}
