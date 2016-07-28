//
//  MapCollectionViewController.swift
//  WLXCarroucel
//
//  Created by María Eugenia Sakuda on 7/27/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import UIKit

final public class MapCollectionViewController: UICollectionViewController {
    
    private static let MapReuseIdentifier = "MapDescriptionCell"
    private var collection = [UIColor.blueColor(), UIColor.brownColor(), UIColor.cyanColor()]
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.registerClass(MapCollectionView.self, forCellWithReuseIdentifier: MapCollectionViewController.MapReuseIdentifier)
        // To use physic library
        self.collectionViewLayout.invalidateLayout()
        
        let customLayout = (collectionView?.collectionViewLayout as? PhysicsCollectionViewFlowLayout)!
        customLayout.setItemSize()
    }
    
    override public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.count
    }
    
    override public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MapCollectionViewController.MapReuseIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = collection[indexPath.row]
        return cell 
    }
    
}
