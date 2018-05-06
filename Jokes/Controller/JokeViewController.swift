//
//  JokeViewController.swift
//  Jokes
//
//  Created by Vinayak Kakade on 5/6/18.
//  Copyright © 2018 Vinayak Kakade. All rights reserved.
//

import UIKit

class JokeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var fName : String?
    var lName : String?
    var viewModel: JokeViewModel = JokeViewModel()
    
    let collectionMargin = CGFloat(COLLECTION_MARGIN)
    let itemSpacing = CGFloat(ITEM_SPACING)
    let itemHeight = CGFloat(ITEM_HEIGHT)
    var itemWidth = CGFloat(ITEM_WIDTH)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false

        // setup collectionview
        setup()
    }
    
    /**
     This method will setup collectionview layout
     */
    func setup() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        itemWidth =  UIScreen.main.bounds.width - collectionMargin * 2.0
        
        layout.sectionInset = UIEdgeInsets(top: CGFloat(ZERO_INT), left: CGFloat(ZERO_INT), bottom: CGFloat(ZERO_INT), right: CGFloat(ZERO_INT))
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: CGFloat(ZERO_INT))
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: CGFloat(ZERO_INT))
        
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        collectionView!.collectionViewLayout = layout
        collectionView?.decelerationRate = UIScrollViewDecelerationRateNormal
    }

    @IBAction func backToPrevView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     Reload collectionview and loadn new jokes
     */
    @IBAction func reloadNewsData(_ sender: Any) {
        self.pageControl.currentPage = 0;
        self.collectionView .scrollToItem(at: IndexPath(row: ZERO_INT, section: ZERO_INT), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        
        // wait till collection view scroll to first view horizontally
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            self?.viewModel.refreshData()
            self?.collectionView.reloadData()
        }
    }
    
    // MARK: - UICollectionView delegates
    /**
     This method will return number of section in collectionview
     */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSectionsToDisplay()
    }
    
    /**
     This method will return number of row in each sectoin of collectionview
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = viewModel.numberOfItemsToDisplay(section)
        return viewModel.numberOfItemsToDisplay(section)
    }
    
    /**
     This method will return cell of collectionview 
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.collectionView(collectionView, for: indexPath, urlForService: String(format: SERVICE_URL, fName!, lName!))
    }
    
    // MARK: - UIScrollViewDelegate protocol
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView!.contentSize.width)
        let currentPage = Float(self.pageControl.currentPage)
        
        let newPage = viewModel.scrollViewWillEndDragging(pageWidth, targetContentOffset: targetXContentOffset, contentWidth: contentWidth, currentPage: currentPage, velocity: velocity)
        
        self.pageControl.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
