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
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetup()
    }
    
    /// Screen settings
    private func pageSetup() {
        title = "Movie List"
        searchControllerSettings()
        closureSetup()
        tableViewSetup()
        getMovieList()
    }
    
    private func getMovieList() {
        self.displayActivityIndicator(onView: self.view)
        if viewModel.movieListBaseModel != nil {
            showLoadMoreDataView(true)
        }
        viewModel.getMoveiListData()
    }
    
    private func showLoadMoreDataView(_ show: Bool) {
        footerView.isHidden = show ? true : true
        activityIndicator.isHidden = show ? true : false
    }

}
extension MovieListViewController  {
    /// Clouser setup methods
    private func closureSetup() {
        // add error handling
        viewModel.onErrorHandling = { [weak self] error in
            DispatchQueue.main.async {
                self?.removeActivityIndicator()
                switch error {
                case .custom(let message):
                    self?.displayAlert(message: message)
                    break
                default:
                    self?.displayAlert(message: error?.localizedDescription ?? "Error")
                    break
                }
            }
        }
        //refresh screen
        viewModel.onRefreshHandling = { [weak self] in
            DispatchQueue.main.async {
                self?.tableViewReload()
            }
        }
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
    
    private func tableViewReload() {
        removeActivityIndicator()
        tableViewList.reloadData()
        showLoadMoreDataView(false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = viewModel.numberOfMovies()
        labelNoDataFound.isHidden = ((rowCount == 0) ? false : true)
        return rowCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifer, for: indexPath) as? MovieListTableViewCell
            else { return UITableViewCell() }
        let movie = viewModel.movie(at: indexPath.row)
        cell.cellDataSet(data: movie)
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
