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
    
    private(set) public var reactiveUserInterfaces = [String : ReactiveUserInterface]()
    
    public init(reactiveController: ReactiveController, presentingViewController: UIViewController) {
        self.reactiveController = reactiveController
        self.presentingViewController = presentingViewController
    }
    
    /// Will find the Top View Controller if it's a Navigation Controller.
    ///
    /// - Parameter name: Storyboard name
    /// - Returns: User Interface
    public func loadReactiveUserInterface(identifier: String, fromStoryboard name: String) -> ReactiveUserInterface {
        precondition(reactiveUserInterfaces[identifier] == nil, "ReactiveUserInterface \(identifier) is already loaded")
        
        let storyboard = UIStoryboard(name: name, bundle: nil)
        var reactiveUserInterface = storyboard.instantiateInitialViewController() as! ReactiveUserInterface
        // If it's a Navigation Controller load it's Top View Controller if it has one.
        // We don't care about the Navigation Controller itself. We can always get it from the Top View Controller.
        if let topViewController = (reactiveUserInterface as? ReactiveNavigationController)?.topViewController {
            reactiveUserInterface = topViewController as! ReactiveUserInterface
        }
        reactiveController.add(reactiveUserInterface: reactiveUserInterface)
        reactiveUserInterfaces[identifier] = reactiveUserInterface
        
        return reactiveUserInterface
    }
    
    public func unloadReactiveUserInterface(identifier: String) {
        precondition(reactiveUserInterfaces[identifier] != nil, "ReactiveUserInterface \(identifier) is not loaded")
        
        reactiveController.remove(reactiveUserInterface: reactiveUserInterfaces[identifier]!)
        reactiveUserInterfaces[identifier] = nil
    }
    
    deinit {
        debugPrint("\(NSStringFromClass(type(of: self))) deallocated")
    }
}
