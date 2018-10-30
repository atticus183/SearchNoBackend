//
//  SearchBarInNavBarVC.swift
//  SearchNoBackend
//
//  Created by Josh R on 10/29/18.
//  Copyright © 2018 Josh R. All rights reserved.
//

import UIKit

class SearchBarInNavBarVC: UIViewController {
    
    
    let cellID = "cell2"
    
    @IBOutlet weak var tableView: UITableView!
    
    var filteredTodos = [Todo]()
    var isFiltering = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        setupSearchInNavBar()
    }
    
    //Search Setup
    let searchController = UISearchController(searchResultsController: nil)

    func setupSearchInNavBar() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        isFiltering = true
        filteredTodos = searchText.isEmpty ? todos : todos.filter({ todo -> Bool in
            return todo.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFilteringFunc() -> Bool {
        isFiltering = true
        return searchController.isActive && !searchBarIsEmpty()
    }

}

extension SearchBarInNavBarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredTodos.count : todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else { return UITableViewCell() }
        
        let todo = isFiltering ? filteredTodos[indexPath.row] : todos[indexPath.row]
        
        cell.textLabel?.text = todo.name
        cell.accessoryType = todo.isDone ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        
        todo.isDone.toggle()
        
        tableView.reloadData()
    }
    
    
}

extension SearchBarInNavBarVC: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        isFiltering = true
//        filteredTodos = searchText.isEmpty ? todos : todos.filter({ todo -> Bool in
//            return todo.name.lowercased().contains(searchText.lowercased())
//        })
//
//        tableView.reloadData()
//    }
//
////    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
////        searchBar.text = nil
////        searchBar.endEditing(true)
////
////        isFiltering = false
////        tableView.reloadData()
////    }
}

extension SearchBarInNavBarVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
