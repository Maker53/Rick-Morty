//
//  CharacterDetailsViewController.swift
//  Rick&Morty
//
//  Created by Станислав on 15.01.2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    // MARK: - IB Outlets
    
    @IBOutlet var characterDescription: UILabel!
    @IBOutlet var characterImage: CharacterImageView! {
        didSet {
            characterImage.layer.cornerRadius = characterImage.frame.width / 2
        }
    }
    
    // MARK: - Public properties
    var character: Character!
    
    // MARK: - Private properties
    private var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = character.name
        characterDescription.text = character.description
        
        characterImage.fetchImage(from: character.image)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationVC = segue.destination as? UINavigationController {
            guard let episodesVC = navigationVC.topViewController as? EpisodesTableViewController else { return }
            episodesVC.character = character
        }
    }
}
