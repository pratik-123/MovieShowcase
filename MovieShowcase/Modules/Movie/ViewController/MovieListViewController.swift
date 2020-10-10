//
//  MovieListViewController.swift
//  MovieShowcase
//
//  Created by Pratik on 10/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import UIKit

class MovieListViewController: BaseViewController {
    @IBOutlet weak var tableViewList: UITableView!
    @IBOutlet weak var labelNoDataFound: PLTitleLabel!
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetup()
    }
    
    /// Screen settings
    private func pageSetup() {
        title = "Movie List"
        searchControllerSettings()
        tableViewSetup()
    }

}
// MARK: - UISearchBar methods
extension MovieListViewController: UISearchBarDelegate {
    
    /// search controll settings
    private func searchControllerSettings() {
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        navigationItem.searchController = searchController
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            displayActivityIndicator(onView: view)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

    }
}
// MARK: - UITableView methods
extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    /// tableview settings
    private func tableViewSetup() {
        tableViewList.delegate = self
        tableViewList.dataSource = self
        let nib = UINib(nibName: MovieListTableViewCell.identifer, bundle: nil)
        tableViewList.register(nib, forCellReuseIdentifier: MovieListTableViewCell.identifer)
        tableViewList.rowHeight = 198
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = 5
        labelNoDataFound.isHidden = ((rowCount == 0) ? false : true)
        return rowCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifer, for: indexPath) as? MovieListTableViewCell
            else { return UITableViewCell() }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
