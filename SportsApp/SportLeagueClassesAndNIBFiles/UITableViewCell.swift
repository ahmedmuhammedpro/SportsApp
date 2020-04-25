//
//  LeagueTableViewCell.swift
//  SportsApp
//
//  Created by ahmedpro on 4/20/20.
//  Copyright © 2020 Reham Ezzat. All rights reserved.
//
import UIKit

class SportLeaguesTableCell: UITableViewCell {
    
    
    @IBOutlet weak var sportLeagueImageView: UIImageView!
    @IBOutlet weak var sportLeagueLabel: UILabel!
    @IBOutlet weak var youtubeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sportLeagueImageView.layer.cornerRadius = sportLeagueImageView.frame.width / 2
        sportLeagueImageView.clipsToBounds = true
        sportLeagueImageView.layer.borderWidth = 1.0
        sportLeagueImageView.layer.borderColor = UIColor.red.cgColor
        
        youtubeButton.layer.cornerRadius = youtubeButton.frame.width / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
