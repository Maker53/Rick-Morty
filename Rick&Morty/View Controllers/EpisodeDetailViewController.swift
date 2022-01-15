//
//  EpisodeDetailViewController.swift
//  Rick&Morty
//
//  Created by Станислав on 15.01.2022.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var episodeDetailLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Public Properties
    var episode: Episode!
    
    // MARK: - Private Properties
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(episode.description)
    }
}
