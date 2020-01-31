 //
//  PodcastCell.swift
//  Programmatic-UI-Xibs-Storyboards
//
//  Created by Eric Davenport on 1/29/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class PodcastCell: UICollectionViewCell {
    
  @IBOutlet weak var podcastImageView: UIImageView!
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var artistLabel: UILabel!
  var podcast : Podcast?
  
  func updateUI(_ podcast: Podcast){
    podcastImageView.getImage(with: podcast.artworkUrl600) { [weak self] (result) in
      DispatchQueue.main.async {
        self?.titleLabel.text = podcast.collectionName
        self?.artistLabel.text = podcast.artistName
        switch result {
        case .failure:
          self?.podcastImageView.image = UIImage(systemName: "music.mic")
          self?.podcastImageView.tintColor = .black
        case .success(let image):
          self?.podcastImageView.image = image
          
        }
      }

         }
         
    }
  }
