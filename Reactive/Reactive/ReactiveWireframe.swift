//
//  Wireframe.swift
//  Reactive
//
//  Created by Karim Sallam on 21/01/2017.
//  Copyright © 2017 Karim Sallam. All rights reserved.
//

import UIKit

open class ReactiveWireframe: NSObject {
    
    public let reactiveController: ReactiveController
    
    public let presentingViewController: UIViewController
    
    public init(reactiveController: ReactiveController, presentingViewController: UIViewController) {
        self.reactiveController = reactiveController
        self.presentingViewController = presentingViewController
    }
    
    public func loadUserInterfaceFromStoryboard(name: String) -> ReactiveUserInterface {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let reactiveUserInterface = storyboard.instantiateInitialViewController() as! ReactiveUserInterface
        reactiveController.add(reactiveUserInterface: reactiveUserInterface)
        return reactiveUserInterface
    }
    
    deinit {
        debugPrint("\(NSStringFromClass(type(of: self))) deallocated")
    }
}
