//
//  TableViewCell.swift
//  Rick&Morty
//
//  Created by Станислав on 14.01.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var characterFullName: UILabel!
    @IBOutlet var characterImage: UIImageView! {
        didSet {
            characterImage.layer.cornerRadius = characterImage.frame.height / 2
            characterImage.backgroundColor = .white
        }
    }
    
    func configure(with character: Character?) {
        characterFullName.text = character?.name
        
        DispatchQueue.global().async {
            guard let stringURL = character?.image else { return }
            guard let url = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.characterImage.image = UIImage(data: imageData)
            }
        }
    }
}
