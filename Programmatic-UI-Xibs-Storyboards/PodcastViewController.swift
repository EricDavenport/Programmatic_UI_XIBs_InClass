//
//  ViewController.swift
//  Programmatic-UI-Xibs-Storyboards
//
//  Created by Alex Paul on 1/29/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class PodcastViewController: UIViewController {
  
  private let podcastView = PodcastView()
  
  private var podcasts = [Podcast]() {
    didSet {
      DispatchQueue.main.async {
        self.podcastView.collectionView.reloadData()
      }
    }
  }

  override func loadView() {
    view = podcastView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationItem.title = "Podcasts"
    
    podcastView.collectionView.dataSource = self
    podcastView.collectionView.delegate = self
    
    // MARK: collection view cell setup
    // register collectionView cell
    // podcastView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "podcastCell")
    
    // regster collectionView cell using xib/nib
    podcastView.collectionView.register(UINib(nibName: "PodcastCell", bundle: nil), forCellWithReuseIdentifier: "podcastCell")
    fetchPodcasts()
  }
  
  private func fetchPodcasts(_ name: String = "swift") {
    PodcastAPIClient.fetchPodcast(with: name) { (result) in
      switch result {
      case .failure(let appError):
        print("error fetching podcasts: \(appError)")
      case .success(let podcasts):
        self.podcasts = podcasts
      }
    }
  }
}

extension PodcastViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return podcasts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
      fatalError("could not downcast to podcast")
    }
    let podcast = podcasts[indexPath.row]
    cell.updateUI(podcast)
    cell.backgroundColor = .black
    return cell
  }
}

extension PodcastViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // override the default values of the itemSize layout from the collectionView property initializer in the podcastView
    let maxSize: CGSize = UIScreen.main.bounds.size
    let itemWidth: CGFloat = maxSize.width * 0.95  // 95% of the width of device
    return CGSize(width: itemWidth, height: 120)
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let podcast = podcasts[indexPath.row]
    print(podcast.collectionName)
    
    // segue to the PodcastDetailCOntroller
    // access the PodcastDetailController from storyboard
    
    // make sure that the stodyboard id is set for the PodcastDetailController
    let podcastDetailStoryboard = UIStoryboard(name: "PodcastDetail", bundle: nil)
    guard let podcastDetailController = podcastDetailStoryboard.instantiateViewController(identifier: "PodcastDetailController") as? PodcastDetailController else {
      fatalError("failed to downcast to PodcastDetailController")
    }
    podcastDetailController.podcasts = podcast
    // in the coming weeks or next week - we will pass datat using initializers / dependency injection e.g PodcatDetailController(podcast: podcast)
    navigationController?.pushViewController(podcastDetailController, animated: true)
    
    //show(pocastDetailController, sender: nil
  }
}


