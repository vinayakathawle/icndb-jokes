//
//  JokeViewModel.swift
//  Jokes
//
//  Created by Vinayak Kakade on 5/6/18.
//  Copyright © 2018 Vinayak Kakade. All rights reserved.
//

import Foundation
import UIKit

class JokeViewModel: NSObject,UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var items = [String]()
    
    /**
     Initialize the item array with null/blank value
     */
    func refreshData() {
        self.items = [String]()
    }
    
    /**
     Number of section to display on UICollectionView
     */
    func numberOfSectionsToDisplay() -> Int {
        return SECTION_COUNT
    }
    
    /**
     Number of row in section to display on UICollectionView
     */
    func numberOfItemsToDisplay(_ section: Int) -> Int {
        return CELL_COUNT
    }
    
    /**
     Set value on each row of UICollectionView
     */
    func collectionView(_ collectionView: UICollectionView, for indexPath: IndexPath, urlForService aURL:String) -> CustomCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: REUSE_IDENTIFIER, for: indexPath) as! CustomCollectionViewCell
        cell.numLabel.text = "\(indexPath.row + 1)" // display count number
        cell.titleLabel.text = ""

        if self.items.count <= indexPath.row {
            loadJoke(cell, cellForItemAt: indexPath, urlForService: aURL)
        } else {
            cell.titleLabel.text = self.items[indexPath.row] ;
        }
        return cell;
    }

    /**
     This method will Call service and load joke and set to cell label
     
     - parameter cell: Current cell of collectionview
     - parameter cellForItemAt: Indexpath value for current appear cell
     - parameter urlForService: URL for service call
     */
    func loadJoke(_ cell: CustomCollectionViewCell, cellForItemAt indexPath: IndexPath, urlForService aURL:String) {
        cell.indicator.startAnimating()
        // check internet connection rechability.
        if Reachability.isReachable() { // if internet connection working
            APIManager().getJoke(String(format: aURL), successClosure: { (response) in
                if let response = response as? [String:AnyObject]{ // unwraping response to dictionary object
                    if let joke = response[VALUE_KEY]![JOKE_KEY] as? String { // unwrap joke string from response dictionary object
                        self.items.append(joke)
                        DispatchQueue.main.async { // UI update on main thread
                            cell.indicator.stopAnimating()
                            cell.titleLabel.text = joke;
                        }
                    }
                } else { // execute when issue in unwraping response
                    ApplicationUtility.showToast(message: COMMAN_ERROR_MSG)
                }
            }, failureClosure: { (error) in // service call fails
                self.handleWebServiceError(error: error)
            })
        } else { // no internet connection
            ApplicationUtility.showToast(message: NO_INTERNET_MSG)
        }
        
    }

    /**
     This method will give you new page when we scroll horizonatally
     
     - parameter pageWidth: Width of collectionview cell
     - parameter targetContentOffset: X position of new targetContentOffset
     - parameter contentWidth: Collection view contentsize width
     - parameter currentPage: Pagecontrol current page
     - parameter velocity: Velocity
     */
    func scrollViewWillEndDragging(_ pageWidth: Float, targetContentOffset: Float, contentWidth: Float, currentPage: Float, velocity: CGPoint) -> Float {
        var newPage = currentPage

        if velocity.x == 0 {
            newPage = floor( (targetContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? currentPage + 1 : currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }

        return newPage
    }
    
    /**
     Display error in toast
     */
    func handleWebServiceError(error: NSError) -> Void {
        if let errorCode = ErrorCode(rawValue: error.code){
            ApplicationUtility.showToast(message: errorCode.localizedDescription())
        }
    }

}
