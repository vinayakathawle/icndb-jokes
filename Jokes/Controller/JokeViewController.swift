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
    
    let collectionMargin = CGFloat(26)
    let itemSpacing = CGFloat(10)
    let itemHeight = CGFloat(375)
    var itemWidth = CGFloat(0)
    
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
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        
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
        self.collectionView .scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        
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
