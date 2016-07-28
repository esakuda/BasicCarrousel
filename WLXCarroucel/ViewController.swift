//
//  ViewController.swift
//  WLXCarroucel
//
//  Created by María Eugenia Sakuda on 7/27/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var _mapCollectionViewController: MapCollectionViewController?
    
    @IBOutlet weak var containerView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chargeCollection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func chargeCollection() {
        let layout = PhysicsCollectionViewFlowLayout()
        _mapCollectionViewController = MapCollectionViewController.init(collectionViewLayout: layout)
        loadViewController(_mapCollectionViewController!, into: containerView)
    }

}

public extension UIViewController {
    
    /// Loads the childViewController into the specified containerView.
    ///
    /// It can be done after self's view is initialized, as it uses constraints to determine the childViewController size.
    /// Take into account that self will retain the childViewController, so if for any other reason the childViewController is retained in another place, this would
    /// lead to a memory leak. In that case, one should call unloadViewController().
    ///
    /// - parameter childViewController: The controller to load.
    /// - parameter into: The containerView into which the controller will be loaded.
    /// - parameter viewPositioning: Back or Front. Default: Front
    public func loadViewController(childViewController: UIViewController, into containerView: UIView, viewPositioning: ViewPositioning = .Front) {
        childViewController.willMoveToParentViewController(self)
        addChildViewController(childViewController)
        childViewController.didMoveToParentViewController(self)
        childViewController.view.loadInto(containerView, viewPositioning: viewPositioning)
    }
    
    /// Unloads a childViewController and its view from its parentViewController.
    public func unloadFromParentViewController() {
        view.removeFromSuperview()
        removeFromParentViewController()
    }
}

public enum ViewPositioning {
    case Back
    case Front
}

public extension UIView {
    
    /// Loads the view into the specified containerView.
    ///
    /// It can be done after self's view is initialized, as it uses constraints to determine the size.
    ///
    /// - parameter containerView: The container view.
    /// - parameter viewPositioning: Back or Front. Default: Front
    public func loadInto(containerView: UIView, viewPositioning: ViewPositioning = .Front) {
        containerView.addSubview(self)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 9.0, *) {
            containerView.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
            containerView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
            containerView.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor).active = true
            containerView.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor).active = true
        } else {
            // Fallback on earlier versions
        }
        
        if case viewPositioning = ViewPositioning.Back {
            containerView.sendSubviewToBack(self)
        }
    }
}

