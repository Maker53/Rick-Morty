//
//  CharactersTableViewController.swift
//  Rick&Morty
//
//  Created by Станислав on 13.01.2022.
//

import UIKit

class CharactersTableViewController: UITableViewController {

    var rickAndMorty: RickAndMorty!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData(from: Link.link.rawValue)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rickAndMorty?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        
        return cell
    }
    
    private func fetchData(from url: String) {
        NetworkManager.shared.fetch(dataType: RickAndMorty.self, from: url) { result in
            switch result {
            case .success(let type):
                self.rickAndMorty = type
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

