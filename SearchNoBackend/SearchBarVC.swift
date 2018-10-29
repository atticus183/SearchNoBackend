//
//  SearchBarVC.swift
//  SearchNoBackend
//
//  Created by Josh R on 10/29/18.
//  Copyright © 2018 Josh R. All rights reserved.
//

import UIKit


class SearchBarVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    var filteredTodos = [Todo]()
    var isFiltering = false
    
    let cellID = "cell1"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self

        setUpSearchBar()
        
        tableview.reloadData()
      
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
        searchBar.showsScopeBar = false
        
        searchBar.layer.borderWidth = 1
//        searchBar.barTintColor = .white
        searchBar.layer.borderColor = UIColor.white.cgColor
    }
    


}

extension SearchBarVC: UITableViewDelegate, UITableViewDataSource {
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
        
        tableView.reloadData()
    }
    
    
}

extension SearchBarVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isFiltering = true
        filteredTodos = searchText.isEmpty ? todos : todos.filter({ todo -> Bool in
            return todo.name.lowercased().contains(searchText.lowercased())
        })
        
        tableview.reloadData()
    }
}
