//
//  ItunesItemTableViewCell.swift
//  itunesSearchWithAPI
//
//  Created by Kaden Hendrickson on 5/16/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class ItunesItemTableViewCell: UITableViewCell {
    
    var itunesResult: itunesResults? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    func updateViews() {
        guard let itunesResult = itunesResult else {return}
        trackNameLabel.text = itunesResult.track
        albumLabel.text = itunesResult.album
        artistLabel.text = itunesResult.artist
    }
}
