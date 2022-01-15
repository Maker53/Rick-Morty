//
//  CharactersTableViewController.swift
//  Rick&Morty
//
//  Created by Станислав on 13.01.2022.
//

import UIKit

class CharactersTableViewController: UITableViewController {

    // MARK: - Private Properties
    private var rickAndMorty: RickAndMorty!
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCharacters = [Character]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 70
        
        setupSearchController()
        fetchData(from: Link.link.rawValue)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredCharacters.count : rickAndMorty?.results.count ?? 0
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! TableViewCell
        let character = isFiltering ? filteredCharacters[indexPath.row] : rickAndMorty?.results[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = isFiltering ? filteredCharacters[indexPath.row] : rickAndMorty?.results[indexPath.row]
        guard let characterDetailsVC = segue.destination as? CharacterDetailsViewController else { return }
        characterDetailsVC.character = character
    }
    
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        sender.tag == 1
        ? fetchData(from: rickAndMorty?.info.next)
        : fetchData(from: rickAndMorty?.info.prev)
    }
    
    // MARK: - Private Methods
    private func fetchData(from url: String?) {
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
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = .boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
}

// MARK: - UISearchResultsUpdating
extension CharactersTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCharacters = rickAndMorty?.results.filter { character in
            character.name.lowercased().contains(searchText.lowercased())
        } ?? []
        
        tableView.reloadData()
    }
}
