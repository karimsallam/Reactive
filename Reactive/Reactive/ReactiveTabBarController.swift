//
//  ReactiveTabBarController.swift
//  RealTimeMenu
//
//  Created by Karim Sallam on 28/11/2016.
//  Copyright © 2016 Karim Sallam. All rights reserved.
//

import UIKit
import ReactiveSwift

class ReactiveTabBarController: UITabBarController {
    
    public let reactiveState = MutableProperty<ReactiveState>(.loading)
    
    public let viewState = MutableProperty<ViewState>(.Invisible)
    
    public var reactiveIdentifier = UUID().uuidString

    open override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        reactiveState.value = .ready
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewState.value = .WillBecomeVisible
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewState.value = .Visible
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewState.value = .WillBecomeInvisible
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewState.value = .Invisible
    }
    
    open func bind() {
        // Do nothing.
    }
        
    deinit {
        debugPrint("\(NSStringFromClass(type(of: self))) deallocated")
    }
}

extension ReactiveTabBarController: ReactiveUserInterface {
    
    open func prepareForReuse() {
        // Do nothing.
    }
}
