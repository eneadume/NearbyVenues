//
//  VenuesViewController.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/21/22.
//

import UIKit

class VenuesViewController: UIViewController {

    var onAboutSegmentSelected: Callback?
    private var venuesViewModel: VenuesViewModelProtocol
    private var venues = [Venue]()
    private let emptyStateView = EmptyStateView()
    
    var navSegmentControl: UISegmentedControl = {
        let venuesSegmentTitle = Localizable.venuesSegmentControlTitle
        let aboutSegmentTitle = Localizable.aboutSegmentControlTitle
        return UISegmentedControl(items: [venuesSegmentTitle, aboutSegmentTitle])
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VenueTableViewCell.self, forCellReuseIdentifier: VenueTableViewCell.reuseIdentifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        tableView.keyboardDismissMode = .onDrag
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    private lazy var refreshControl: UIRefreshControl = {
        let spinner = UIRefreshControl()
        spinner.tintColor = Color.tint
        spinner.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
        return spinner
    }()
    
    init(venuesViewModel: VenuesViewModelProtocol){
        self.venuesViewModel = venuesViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navSegmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(sender:)), for: .valueChanged)
        self.navigationItem.titleView = navSegmentControl
        self.addSubviews()
        
        self.setupViewModelBindings()
        self.venuesViewModel.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navSegmentControl.selectedSegmentIndex = 0
    }
    
    // MARK: - Actions
    
    @objc private func segmentedControlValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            onAboutSegmentSelected?()
        }
    }
    
    // MARK: - Private Functions
    
    private func addSubviews() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    private func setupViewModelBindings() {
        self.bindDataStateChange()
    }
    
    private func bindDataStateChange() {
        self.venuesViewModel.onDataStateChanged = { [weak self] state in
            guard let self = self else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                switch state {
                case .loading:
                    self.configureForLoading()
                case .loaded(let venues):
                    if venues.isEmpty {
                        self.configureForEmpty()
                    }else {
                        self.configureForLoaded(venues: venues)
                    }
                case .error(let error):
                    self.configureForError(error)
                case .reloading:
                    self.configureForReloading()
                }
            }
        }
    }
    
    // MARK: - Date State Configurations

    private func configureForLoading() {
        refreshControl.removeFromSuperview()

        tableView.backgroundView = emptyStateView
        emptyStateView.isLoading = true
        emptyStateView.title = Localizable.commonActionLoading
        emptyStateView.detail = nil
        emptyStateView.image = Constants.Image.emptyImage
        emptyStateView.imageColor = Color.Label.tertiary
    }

    private func configureForReloading() {
    }

    private func configureForEmpty() {
        self.venues.removeAll()
        refreshControl.removeFromSuperview()

        tableView.backgroundView = emptyStateView
        emptyStateView.isLoading = false
        emptyStateView.title = nil
        emptyStateView.detail = Localizable.patientsEmptyStateTitle
        emptyStateView.image = Constants.Image.emptyImage
        emptyStateView.imageColor = Color.Label.tertiary
        emptyStateView.setButtonTitle(Localizable.commonActionReload)
        emptyStateView.onButtonPressed = { [weak self] in
            self?.pullToRefresh()
        }

        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }

    private func configureForLoaded(venues: [Venue]) {
        self.venues = venues

        tableView.backgroundView = nil
        tableView.addSubview(refreshControl)
        emptyStateView.isLoading = false
        refreshControl.endRefreshing()

        self.tableView.reloadData()
    }

    private func configureForError(_ error: NearbyVenuesError) {
        refreshControl.removeFromSuperview()

        emptyStateView.isLoading = false
        emptyStateView.title = error.title
        emptyStateView.detail = error.detail
        emptyStateView.image = Constants.Image.alertImage
        emptyStateView.setButtonTitle(Localizable.commonActionReload)
        emptyStateView.imageColor = Color.warning
        emptyStateView.onButtonPressed = { [weak self] in
            self?.pullToRefresh()
        }

        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }

    @objc private func pullToRefresh() {
        venuesViewModel.reloadData()
    }
}


extension VenuesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: VenueTableViewCell.reuseIdentifier) as? VenueTableViewCell
        else { return UITableViewCell() }
        
        let venue = self.venues[indexPath.row]
        cell.configure(for: venue)
        return cell
    }
    
    
}
