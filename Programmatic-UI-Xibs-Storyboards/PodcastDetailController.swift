//
//  PodcastDetailController.swift
//  Programmatic-UI-Xibs-Storyboards
//
//  Created by Eric Davenport on 1/29/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import ImageKit

class PodcastDetailController: UIViewController {
  
  @IBOutlet weak var podcastDetailImageView: UIImageView!
  @IBOutlet weak var artistNameLabel: UILabel!
  
  var podcasts: Podcast?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
    
  }
  
  private func updateUI() {
    guard let podcast = podcasts else {
      fatalError("unable to load podcast from segue")
    }
    artistNameLabel.text = podcast.artistName
    podcastDetailImageView.getImage(with: podcast.artworkUrl600) { [weak self] (result) in
      switch result {
      case .failure:
        self?.podcastDetailImageView.image = UIImage(systemName: "music.mic")
        self?.podcastDetailImageView.tintColor = .black
      case .success(let image):
        DispatchQueue.main.async {
          self?.podcastDetailImageView.image = image
        }
      }
    }
    
  }
  
  
  
}
