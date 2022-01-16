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
    private var characters: [Character] = [] {
        didSet {
            if characters.count == episode.characters.count {
                characters = characters.sorted { $0.id < $1.id }
            }
        }
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setCharacters()
        episodeDetailLabel.text = episode.description
        title = episode.episode
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let characterDetailsVC = segue.destination as? CharacterDetailsViewController else { return }
        characterDetailsVC.character = sender as? Character
    }
    
    // MARK: - Private Methods
    private func setCharacters() {
        episode.characters.forEach { characterURL in
            NetworkManager.shared.fetch(dataType: Character.self, from: characterURL) { result in
                switch result {
                case .success(let character):
                    self.characters.append(character)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

// MARK: - Table View Data Source
extension EpisodeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episode.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! TableViewCell
        let characterURL = episode.characters[indexPath.row]
        NetworkManager.shared.fetch(dataType: Character.self, from: characterURL) { result in
            switch result {
            case .success(let character):
                cell.configure(with: character)
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
}

// MARK: - Table View Delegate
extension EpisodeDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        performSegue(withIdentifier: "showCharacter", sender: character)
    }
}
