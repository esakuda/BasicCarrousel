////
////  test.swift
////  WLXCarroucel
////
////  Created by María Eugenia Sakuda on 7/28/16.
////  Copyright © 2016 Wolox. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class SpringyCollectionViewFlowLayout: UICollectionViewFlowLayout {
//    
//    var dynamicAnimator:UIDynamicAnimator!
//    var visibleIndexPathsSet:NSMutableSet!
//    var latestDelta:CGFloat! = 0
//    
//    override init() {
//        super.init()
//        initialize()
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//        initialize()
//    }
//    
//    func initialize() {
//        self.minimumInteritemSpacing = 10
//        self.minimumLineSpacing = 10
//        self.itemSize = CGSizeMake(44, 44)
//        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
//        
//        self.dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
//        self.visibleIndexPathsSet = NSMutableSet()
//    }
//    
//    override func prepareLayout() {
//        super.prepareLayout()
//        
//        // Need to overflow our actual visible rect slightly to avoid flickering.
//        let collectionViewViewPort = CGRectMake(
//            self.collectionView!.bounds.origin.x
//            , self.collectionView!.bounds.origin.y
//            , self.collectionView!.frame.size.width
//            , self.collectionView!.frame.size.height)
//        
//        let visibleRect = CGRectInset(collectionViewViewPort, -100, -100)
//        
//        var itemsInVisibleRectArray:NSArray = super.layoutAttributesForElementsInRect(visibleRect)!
//        
//        var itemsIndexPathsInVisibleRectSet:NSSet = NSSet(array: itemsInVisibleRectArray.valueForKey("indexPath") as! Array)
//        
//        // Step 1: Remove any behaviours that are no longer visible. //Qué hace esto!??
//        var noLongerVisibleBehaviors = self.dynamicAnimator.behaviors.filter({ behavior in
//            if let behavior = behavior as? UIAttachmentBehavior {
//                var currentlyVisible = itemsIndexPathsInVisibleRectSet.member(behavior.items[0]) != nil
//                return !currentlyVisible
//            }
//        })
//        
//        for obj in noLongerVisibleBehaviors {
//            self.dynamicAnimator.removeBehavior(obj)
//            self.visibleIndexPathsSet.removeObject(obj.items![0].indexPath)
//        }
//        
//        // Step 2: Add any newly visible behaviors
//        // a "newly visible" item is one that is in the itemsInVisibleRect(set|Array) but not in the visibleIndexPathSet
//        
//        var newlyVisibleItems = itemsInVisibleRectArray.filteredArrayUsingPredicate(NSPredicate(block: { (item, bindings) -> Bool in
//            var attributes = item as! UICollectionViewLayoutAttributes
//            
//            var currentlyVisible = self.visibleIndexPathsSet.member(attributes.indexPath) != nil
//            return !currentlyVisible
//        }))
//        
//        let touchLocation = self.collectionView?.panGestureRecognizer.locationInView(self.collectionView)
//        
//        for (index, item) in enumerate(newlyVisibleItems) {
//            var attributes = item as! UICollectionViewLayoutAttributes
//            var center = item.center
//            var springBehavior = UIAttachmentBehavior(item: attributes, attachedToAnchor: center)
//            springBehavior.length = 0
//            springBehavior.damping = 0.8
//            springBehavior.frequency = 1
//            
//            // if our touchlocation is not (0,0), we'll need to adjust our item's center "in flight"
//            if (!CGPointEqualToPoint(CGPointZero, touchLocation!)) {
//                
//                let yDistanceFromTouch = CGFloat(fabsf(Float(touchLocation!.y - springBehavior.anchorPoint.y)))
//                let xDistanceFromTouch = CGFloat(fabsf(Float(touchLocation!.x - springBehavior.anchorPoint.x)))
//                let scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1500
//                
//                let item = (springBehavior as UIAttachmentBehavior).items[0] as! UICollectionViewLayoutAttributes
//                
//                var center:CGPoint = item.center
//                
//                if (self.latestDelta < 0) {
//                    center.y += CGFloat(max(Float(self.latestDelta), Float(self.latestDelta * scrollResistance)))
//                }
//                else {
//                    center.y += CGFloat(min(Float(self.latestDelta), Float(self.latestDelta * scrollResistance)))
//                }
//                item.center = center
//            }
//            self.dynamicAnimator.addBehavior(springBehavior)
//            self.visibleIndexPathsSet.addObject(item.indexPath)
//        }
//    }
//    
//    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
//        return self.dynamicAnimator.itemsInRect(rect)
//    }
//    
//    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
//        return self.dynamicAnimator.layoutAttributesForCellAtIndexPath(indexPath)
//    }
//    
//    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
//        var scrollView = self.collectionView!
//        
//        var delta = newBounds.origin.y - scrollView.bounds.origin.y
//        
//        self.latestDelta = delta
//        
//        var touchLocation:CGPoint = self.collectionView!.panGestureRecognizer.locationInView(self.collectionView)
//        
//        for (index, springBehavior) in enumerate(self.dynamicAnimator!.behaviors) {
//            let yDistanceFromTouch = CGFloat(fabsf(Float(touchLocation.y - springBehavior.anchorPoint.y)))
//            let xDistanceFromTouch = CGFloat(fabsf(Float(touchLocation.x - springBehavior.anchorPoint.x)))
//            let scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1500
//            
//            let item = (springBehavior as! UIAttachmentBehavior).items[0] as! UICollectionViewLayoutAttributes
//            
//            var center:CGPoint = item.center
//            
//            if (delta < 0) {
//                center.y += CGFloat(max(delta, delta*scrollResistance))
//            }
//            else {
//                center.y += CGFloat(min(delta, delta*scrollResistance))
//            }
//            item.center = center
//            
//            self.dynamicAnimator?.updateItemUsingCurrentState(item)
//            
//        }
//        
//        return false
//    }
//}
