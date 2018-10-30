//
//  SearchBarToNewScreen.swift
//  SearchNoBackend
//
//  Created by Josh R on 10/29/18.
//  Copyright © 2018 Josh R. All rights reserved.
//

import UIKit

class SearchBarToNewScreen: UIViewController {
    
    let cellID = "cell3"
    
    @IBOutlet weak var searchIcon: UIBarButtonItem!
    @IBAction func searchIconAction(_ sender: UIBarButtonItem) {
        isFiltering.toggle()
        setupSearchBar()
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    var filteredTodos = [Todo]()
    var isFiltering = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        
        if isFiltering {
            setupSearchBar()
        }
        
    }
    
    func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.prefersLargeTitles = false
        searchBar.showsCancelButton = true
        searchBar.delegate = self
    }
    

}

extension SearchBarToNewScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredTodos.count : todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: cellID) else { return UITableViewCell() }
        
        let todo = isFiltering ? filteredTodos[indexPath.row] : todos[indexPath.row]
        
        cell.textLabel?.text = todo.name
        cell.accessoryType = todo.isDone ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        
        todo.isDone.toggle()
        
        tableview.reloadData()
    }
    
    
}

extension SearchBarToNewScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isFiltering = true
        filteredTodos = searchText.isEmpty ? todos : todos.filter({ todo -> Bool in
            return todo.name.lowercased().contains(searchText.lowercased())
        })
        
        tableview.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        navigationItem.titleView = nil
        navigationController?.navigationBar.prefersLargeTitles = true
        
        isFiltering = false
        tableview.reloadData()
        
    }
}
