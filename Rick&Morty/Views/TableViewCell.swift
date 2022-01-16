//
//  TableViewCell.swift
//  Rick&Morty
//
//  Created by Станислав on 14.01.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var characterFullName: UILabel!
    @IBOutlet var characterImage: CharacterImageView! {
        didSet {
            characterImage.layer.cornerRadius = characterImage.frame.height / 2
            characterImage.backgroundColor = .white
        }
    }
    
    func configure(with character: Character?) {
        characterFullName.text = character?.name
        
        characterImage.fetchImage(from: character?.image ?? "")
    }
}
