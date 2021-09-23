//
//  ChooseGlazeTableViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 13.04.2021.
//
import UIKit

class ChooseGlazeTableViewController: UITableViewController {

    let interactor: ClaysGlazeLocalStorageService
    lazy var searchBar: UISearchBar = UISearchBar()
    var initialCenter = CGPoint()
    var viewModel: ChooseGlazeTableViewViewModelType?

    // MARK: - Init
    init(interactor: ClaysGlazeLocalStorageService) {
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
        viewModel = ChooseGlazeTableViewViewModel(interactor: interactor)

        // Load data via viewModel
        viewModel?.loadData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "glazeCell", for: indexPath) as? ClayCell

        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel

        return tableViewCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Go to next VC
        let glazeTemperatureViewController = GlazeTemperatureTableViewController()
        viewModel?.selectRow(atIndexPath: indexPath)

        glazeTemperatureViewController.viewModel = viewModel?.viewModelForSelectedRow()

        self.navigationController?.pushViewController(glazeTemperatureViewController, animated: true)
    }

    // MARK: - Section headers setup
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel else { return nil}

        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "glazesListHeader") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "glazesListHeader")
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

    // MARK: Tap on information button
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)

        let glazeInfoView = InformationView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height + 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 400))

        glazeInfoView.delegate = self
        glazeInfoView.viewModel = viewModel.viewModelForInformationView()
        tableView.addSubviews(glazeInfoView)

        tableView.isScrollEnabled = false
        Animation.setBlur(view: self.view, contentView: glazeInfoView)
        glazeInfoView.alpha = 1
        Animation.showView(view: glazeInfoView)

        NotificationCenter.default.post(name: Notification.Name("ShowInfoView"), object: nil)

        // Add pan gesture to drag info view
        let panGesture = UIPanGestureRecognizer(target: self, action:#selector(handlePanGesture(sender:)))
            glazeInfoView.addGestureRecognizer(panGesture)
    }

    // MARK: - Private
    fileprivate func setupTableView() {
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .BackgroundColor1
        navigationController?.navigationBar.barTintColor = .BackgroundColor1
        navigationItem.title = "ВЫБЕРИ ГЛАЗУРЬ:"
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "chooseGlazeTableView"
        clearsSelectionOnViewWillAppear = true
        tableView.register(ClayCell.self, forCellReuseIdentifier: "glazeCell")
    }
}
