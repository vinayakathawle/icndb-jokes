//
//  CustomCollectionViewCell.swift
//  Jokes
//
//  Created by Vinayak Kakade on 5/6/18.
//  Copyright © 2018 Vinayak Kakade. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var numBG: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        numLabel.applyAmbossEffect()
        
        // making number background in circle
        numBG.makeCircular()
        
        self.shapeCellView()
    }

}



















































