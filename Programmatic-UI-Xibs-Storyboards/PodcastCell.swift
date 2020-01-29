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
  
  var podcast : Podcast?
  
  func updateUI(_ podcast: Podcast){
    podcastImageView.getImage(with: podcast.artworkUrl600) { [weak self] (result) in
           switch result {
           case .failure:
             self?.podcastImageView.image = UIImage(systemName: "music.mic")
             self?.podcastImageView.tintColor = .black
           case .success(let image):
             DispatchQueue.main.async {
               self?.podcastImageView.image = image
             }
           }
         }
         
    }
  }

 
