//
//  MoviesCell.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 11/10/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import UIKit


class MoviesCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var longDiscriptionLabel: UILabel!
    
    //MARK:- LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- Public Methods
    func setupCellData(type: String, media: Media){
        switch type {
        case MediaType.music.rawValue:
            movieLabel.text = media.trackName  ?? " "
            longDiscriptionLabel.text = media.artistName ?? " "
        case MediaType.tvShow.rawValue:
            movieLabel.text = media.artistName  ?? " "
            longDiscriptionLabel.text = media.longDescription ?? " "
        case MediaType.movie.rawValue:
            movieLabel.text = media.trackName  ?? " "
            longDiscriptionLabel.text = media.longDescription ?? " "
        default:
            if media.longDescription == nil{
                movieLabel.text = media.trackName  ?? " "
                longDiscriptionLabel.text = media.artistName ?? " "
            }else {
                movieLabel.text = media.artistName  ?? " "
                longDiscriptionLabel.text = media.longDescription ?? " "
            }
        }
        self.movieImageView.sd_setImage(with: URL(string: media.poster ?? ""), completed: nil)
    }
    
    //MARK:- Actions
    @IBAction func mediaImageBtnTapped(_ sender: UIButton) {
        let frame = movieImageView.frame.origin.x
        self.movieImageView.frame.origin.x += 4
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, animations: {
            self.movieImageView.frame.origin.x -= 8
            self.movieImageView.frame.origin.x = frame
        }, completion: nil)
    }
}
