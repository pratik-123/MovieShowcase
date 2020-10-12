//
//  MovieDetailsViewController.swift
//  MovieShowcase
//
//  Created by Pratik on 11/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import UIKit

class MovieDetailsViewController: BaseViewController {
    @IBOutlet weak var imageViewPoster: PLImageView!
    @IBOutlet weak var labelReleaseDate: PLTitleLabel!
    @IBOutlet weak var labelMovieName: PLTitleLabel!
    @IBOutlet weak var labelOverview: PLSubTitleLightLabel!
    @IBOutlet weak var viewTableViewHeader: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewProductionCompanyContainer: UIView!
    @IBOutlet weak var collectionViewProductionCompny: UICollectionView!
    @IBOutlet weak var collectionViewSimilarMovie: UICollectionView!
    @IBOutlet weak var viewSimilarMovie: UIView!
    
    var viewModel: MovieDetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSettings()
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let headerView = tableView.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
        if let footerView = tableView.tableFooterView {
            let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var footerFrame = footerView.frame
            if height != footerFrame.size.height {
                footerFrame.size.height = height
                footerView.frame = footerFrame
                tableView.tableFooterView = footerView
            }
        }
    }
    
    private func pageSettings() {
        title = "Details"
        closureSetup()
        collectionViewProductCompanySetup()
        collectionViewSimilarMovieSetup()
        tableViewSetting()
        movieDetailsSet()
        getMovieDetails()
        getSimilarMovie()
        getMovieCreditDetails()
        getMovieReview()
    }
    
    private func movieDetailsSet() {
        let movie = viewModel?.objMovie
        labelReleaseDate.text = movie?.displayDate
        if let imageName = movie?.poster_path {
            let endPoint = APIManager.EndPoint.PosterImage(imageName: imageName)
            let request = APIManager.EndPoint.generateRequest(for: endPoint)
            imageViewPoster.setImage(forURL: request.url)
        }
        labelMovieName.text = movie?.title
        labelOverview.text = movie?.overview
        viewProductionCompanyContainer.isHidden = true
    }
    
    private func getMovieDetails() {
        viewModel?.getMovieDetailsData()
    }
    
    private func getSimilarMovie() {
        viewModel?.getSimilarMovieDetailsData()
    }
    
    private func getMovieCreditDetails() {
        viewModel?.getMovieCreditsDetailsData()
    }
    
    private func getMovieReview() {
        viewModel?.getMovieReviewDetailsData()
    }
}
extension MovieDetailsViewController  {
    /// Clouser setup methods
    private func closureSetup() {
        // add error handling
        viewModel?.onErrorHandling = { [weak self] error in
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
        viewModel?.onRefreshHandling = { [weak self] (type) in
            DispatchQueue.main.async {
                switch type {
                case .ProductionCompanies:
                    self?.collectionViewProductCompanyReload()
                    break
                case .SimilarMovie:
                    self?.collectionViewimilarMovieReload()
                    break
                case .MovieCredit:
                    break
                case .MovieReview:
                    self?.tableViewReload()
                    break
                }
            }
        }
    }
}
extension MovieDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private func collectionViewProductCompanySetup() {
        collectionViewProductionCompny.delegate = self
        collectionViewProductionCompny.dataSource = self
        let nib = UINib(nibName: MovieProductionCompanyCollectionViewCell.identifer, bundle: nil)
        collectionViewProductionCompny.register(nib, forCellWithReuseIdentifier: MovieProductionCompanyCollectionViewCell.identifer)
    }
    private func collectionViewProductCompanyReload() {
        collectionViewProductionCompny.reloadData()
    }
    private func collectionViewSimilarMovieSetup() {
        collectionViewSimilarMovie.delegate = self
        collectionViewSimilarMovie.dataSource = self
        let nib = UINib(nibName: MovieSimilerCollectionViewCell.identifer, bundle: nil)
        collectionViewSimilarMovie.register(nib, forCellWithReuseIdentifier: MovieSimilerCollectionViewCell.identifer)
    }
    private func collectionViewimilarMovieReload() {
        collectionViewSimilarMovie.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewProductionCompny {
            let rowCount = viewModel?.numberOfCompanies() ?? 0
            viewProductionCompanyContainer.isHidden = (rowCount == 0) ? true : false
            return rowCount
        } else if collectionView == collectionViewSimilarMovie {
            let rowCount = viewModel?.numberOfSimilarMovie() ?? 0
            viewSimilarMovie.isHidden = (rowCount == 0) ? true : false
            return rowCount
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewProductionCompny {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieProductionCompanyCollectionViewCell.identifer, for: indexPath) as? MovieProductionCompanyCollectionViewCell else {
                return UICollectionViewCell()
            }
            let company = viewModel?.company(at: indexPath.row)
            cell.cellDataSet(obj: company)
            return cell
        } else if collectionView == collectionViewSimilarMovie {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSimilerCollectionViewCell.identifer, for: indexPath) as? MovieSimilerCollectionViewCell else {
                return UICollectionViewCell()
            }
            let movie = viewModel?.similarMovie(at: indexPath.row)
            cell.cellDataSet(obj: movie)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewProductionCompny {
            return CGSize(width:160, height: collectionView.bounds.size.height)
        } else if collectionView == collectionViewSimilarMovie {
            return CGSize(width:100, height: 130)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == collectionViewSimilarMovie {
            if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
                getSimilarMovie()
            }
        }
    }
}
extension MovieDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableViewSetting() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: MovieReviewTableViewCell.identifer, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MovieReviewTableViewCell.identifer)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
    func tableViewReload() {
        tableView.reloadData()
        view.layoutIfNeeded()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRow = viewModel?.numberOfReviews() ?? 0
        return numberOfRow
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let numberOfRow = viewModel?.numberOfReviews() ?? 0
        if numberOfRow == 0 {
            return 0
        }
        return 20
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Reviews"
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = #colorLiteral(red: 0.2349999994, green: 0.2389999926, blue: 0.275000006, alpha: 1)
            headerView.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieReviewTableViewCell.identifer, for: indexPath) as? MovieReviewTableViewCell
            else { return UITableViewCell() }
        let review = viewModel?.movieReview(at: indexPath.row)
        cell.cellDataSet(obj: review)
        return cell
    }
}
