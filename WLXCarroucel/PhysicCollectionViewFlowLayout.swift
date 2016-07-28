//
//  PhysicCollectionViewFlowLayout.swift
//  WLXCarroucel
//
//  Created by María Eugenia Sakuda on 7/28/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import UIKit

final public class PhysicsCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    private var _animator: UIDynamicAnimator?
    
    override init() {
        super.init()
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override public func prepareLayout() {
        super.prepareLayout()
        let collectionViewViewPort = CGRectMake(
            self.collectionView!.bounds.origin.x
            , self.collectionView!.bounds.origin.y
            , self.collectionView!.frame.size.width
            , self.collectionView!.frame.size.height)
        let items = super.layoutAttributesForElementsInRect(CGRectMake(0.0, 0.0, collectionViewViewPort.width, collectionViewViewPort.height))
        if _animator!.behaviors.count == 0 {
            for item in items! {
//                let viewCenter = CGPoint(x: item.center.x + (collectionView?.frame.size.width)! / 2 ,y: item.center.y + (collectionView?.frame.size.height)! / 2)
                let behaviour = UIAttachmentBehavior.init(item: item, attachedToAnchor: item.center)
                behaviour.length = 0.0;
                behaviour.damping = 0.0;
                behaviour.frequency = 1.0;
                self._animator?.addBehavior(behaviour)
            }
        }
    }
    
    override public func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return _animator?.itemsInRect(rect) as? [UICollectionViewLayoutAttributes]
    }
    
    override public func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return _animator?.layoutAttributesForCellAtIndexPath(indexPath)
    }
    
    override public func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        let scrollView = collectionView
        let delta = newBounds.origin.x - (scrollView?.bounds.origin.x)!
//        let touchLocation = collectionView?.panGestureRecognizer.locationInView(collectionView)
        
        for behaviour in (_animator?.behaviors)! {
            if let behaviour = behaviour as? UIAttachmentBehavior {
//                let yDistanceFromTouch = fabs(touchLocation!.y - behaviour.anchorPoint.y)
//                let xDistanceFromTouch = fabs(touchLocation!.x - behaviour.anchorPoint.x)
//                let scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1500
                
                let item = behaviour.items.first
                var center = item?.center
                center!.x += 50
                item?.center = center!
                _animator?.updateItemUsingCurrentState(item!)
            }
        }
        
        return false
    }
    
    public func resetLayour() {
        _animator?.removeAllBehaviors()
        prepareLayout()
    }
    
    public func setItemSize() {
        itemSize = calculateItemSize()
    }
}

private extension PhysicsCollectionViewFlowLayout {
    
    func initialize() {
        minimumInteritemSpacing = 10;
        minimumLineSpacing = 10;
        sectionInset = UIEdgeInsets(top: 15.0, left: 10.0, bottom: 15.0, right: 10.0)
        scrollDirection = .Horizontal
        _animator = UIDynamicAnimator.init(collectionViewLayout: self)
    }
    
    func calculateItemSize() -> CGSize {
        let originalWidth = Double((collectionView?.frame.size.width)!)
        let separation = 10.0
        let porcentage = 0.01
        let width = originalWidth - originalWidth * porcentage * 2 - separation * 2
        return CGSize(width: width, height: 100)
    }
}
