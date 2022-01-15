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
    @IBOutlet var characterImage: UIImageView! {
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

        setupActivityIndicator()
        
        title = character.name
        characterDescription.text = character.description
        
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.fetchImage(from: self.character.image) else { return }
            DispatchQueue.main.async {
                self.characterImage.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

// MARK: - Private Methods
extension CharacterDetailsViewController {
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.center = characterImage.center
        
        view.addSubview(activityIndicator)
    }
}
