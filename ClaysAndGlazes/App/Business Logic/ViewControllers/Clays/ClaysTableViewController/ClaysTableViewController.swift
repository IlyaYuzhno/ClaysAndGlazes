//
//  ClaysTableViewController.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//
import UIKit

class ClaysTableViewController: UITableViewController {

    var isShown = false
    let interactor: Interactor
    lazy var searchBar: UISearchBar = UISearchBar()
    let startView = StartView(frame: CGRect(x: 5, y: 50, width: UIScreen.main.bounds.width - 10, height: UIScreen.main.bounds.height - 270))
    var initialCenter = CGPoint()
    var viewModel: ClaysTableViewViewModelType?

    // MARK: - Init
    init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        hideKeyboardWhenTappedAroundOnTableView()
        viewModel = ClaysTableViewViewModel(interactor: interactor)

        // Load data via viewModel
        viewModel?.loadData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let isShown: Bool = UserDefaults.standard.bool(forKey: "isShown")
        if isShown == false {
            showStartView()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(forSection: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clayCell", for: indexPath) as? ClayCell

        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel

        return tableViewCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)

        // Go to next VC
        let temperatureViewController = ClaysTemperatureTableViewController(interactor: interactor)
        viewModel.selectRow(atIndexPath: indexPath)

        temperatureViewController.viewModel = viewModel.viewModelForSelectedRow()

        self.navigationController?.pushViewController(temperatureViewController, animated: true)
    }

    // MARK: - Section headers setup
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel else { return nil}

        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.titleLabel.text = viewModel.sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(collapsed: viewModel.sections[section].collapsed)
        header.section = section
        header.delegate = self
        return header
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let viewModel = viewModel else { return UITableView.automaticDimension}

        return viewModel.sections[(indexPath as NSIndexPath).section].collapsed ? 0 : UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let viewModel = viewModel else { return 0}
        return viewModel.isSearching ? 0 : 60
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20
    }

    // MARK: - Tap on information button
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)

        let clayInfoView = InformationView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height + 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 100))

        clayInfoView.delegate = self
        clayInfoView.viewModel = viewModel.viewModelForInformationView()
        tableView.addSubviews(clayInfoView)

        tableView.isScrollEnabled = false
        Animation.setBlur(view: self.view, contentView: clayInfoView)
        clayInfoView.alpha = 1
        Animation.showView(view: clayInfoView)

        NotificationCenter.default.post(name: Notification.Name("ShowInfoView"), object: nil)

        // Add pan gesture to drag info view
        let panGesture = UIPanGestureRecognizer(target: self, action:#selector(handlePanGesture(sender:)))
        clayInfoView.addGestureRecognizer(panGesture)
        panGesture.cancelsTouchesInView = false
    }

    // MARK: - Private
    fileprivate func setupTableView() {
        tableView.addSubviews(startView)
        startView.alpha = 0
        startView.delegate = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .BackgroundColor1
        navigationController?.navigationBar.barTintColor = .BackgroundColor1
        navigationItem.title = "ВЫБЕРИ МАССУ:"
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "claysTableView"
        clearsSelectionOnViewWillAppear = true
        tableView.register(ClayCell.self, forCellReuseIdentifier: "clayCell")
    }
}
