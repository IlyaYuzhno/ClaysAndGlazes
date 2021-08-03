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
    let clayInfoView = InformationView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height + 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 100), clayName: "", clayInfo: "")
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

    // MARK: Tap on information button
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }

        tableView.isScrollEnabled = false
        Animation.setBlur(view: self.view, contentView: clayInfoView)
        self.clayInfoView.alpha = 1
        if viewModel.isSearching {
            showClayInfoView(clayName: viewModel.filteredClaysList[indexPath.row], clayInfo: viewModel.claysInfoDictionary[viewModel.filteredClaysList[indexPath.row]] ?? "")
        } else {
            showClayInfoView(clayName: viewModel.sections[indexPath.section].items[indexPath.row], clayInfo: viewModel.sections[indexPath.section].info[indexPath.row])
        }

        // Add pan gesture to drag info view
        let panGesture = UIPanGestureRecognizer(target: self, action:#selector(handlePanGesture(sender:)))
        clayInfoView.addGestureRecognizer(panGesture)
        panGesture.cancelsTouchesInView = false
    }

    // MARK: - Private
    fileprivate func setupTableView() {
        tableView.addSubviews(clayInfoView, startView)
        startView.alpha = 0
        clayInfoView.alpha = 0
        clayInfoView.delegate = self
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

    fileprivate func showClayInfoView(clayName: String, clayInfo: String) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showInfoView"), object: nil, userInfo: ["clayName": clayName, "clayInfo": clayInfo])
        Animation.showView(view: clayInfoView)
    }
}

// MARK: - Extensions

// MARK: Searchbar
extension ClaysTableViewController: UISearchBarDelegate {
    @available(iOS 13.0, *)
    private func setupSearchBar() {
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "  Поиск..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = true
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        searchBar.searchTextField.backgroundColor = .SearchBarColor
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text == "" {
            viewModel?.isSearching = false
            tableView.reloadData()
        } else {
            viewModel?.isSearching = true
            viewModel?.filteredClaysList = []
            let searched = (viewModel?.claysList.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive) != nil
            })) ?? [""]
            viewModel?.filteredClaysList = searched
            tableView.reloadData()
        }
    }
}

// MARK: Collapse or not collapse sections
extension ClaysTableViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {

        let collapsed = !(viewModel?.sections[section].collapsed ?? false)

        // Toggle collapse
        viewModel?.sections[section].collapsed = collapsed
        header.setCollapsed(collapsed: collapsed)
        tableView.setContentOffset(.zero, animated: true)

        // Reload the whole section
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}

// MARK: Info View Delegate
extension ClaysTableViewController: InformationViewDelegate {
    // Hide Nav bar when full screen image shown
    func hideNavigationBar(sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = true
    }

    // Show Nav bar when full screen image shown
    func showNavigationBar(sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
    }
}

// MARK: Show start view
extension ClaysTableViewController {
    func showStartView() {
        tableView.isScrollEnabled = false
        view.bringSubviewToFront(startView)
        startView.alpha = 1
    }
}

// MARK: Hide start view
extension ClaysTableViewController: StartViewDelegate {
    func startViewButtonPressed() {
        isShown = true
        startView.alpha = 0
        startView.removeFromSuperview()
        tableView.isScrollEnabled = true
        UserDefaults.standard.set(isShown, forKey: "isShown")
    }
}

// MARK: Drag and Close Info View
extension ClaysTableViewController {
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        guard sender.view != nil else {return}
        let piece = sender.view!
        let translation = sender.translation(in: piece.superview)
        let velocity = sender.velocity(in: view)

        switch sender.state {
        case .began:
            // Save the view's original position.
            self.initialCenter = piece.center
        case .changed:
            // Add the X and Y translation to the view's original position.
            let newCenter = CGPoint(x: initialCenter.x, y: initialCenter.y + translation.y)
            piece.center = newCenter
        case .failed:
            piece.center = initialCenter
        case .cancelled:
            piece.center = initialCenter
        case .ended:
            // If pan velocity is high do the Info View hide
            if abs(velocity.y) > 500 {
                // Hide Info View...
                Animation.hideView(view: clayInfoView)
                Animation.removeBlur()
                tableView.isScrollEnabled = true
                self.navigationController?.isNavigationBarHidden = false

                // Close full screen image
                NotificationCenter.default.post(name: Notification.Name("CloseFullScreenImageFromClays"), object: nil)
            }
        default:
            break
        }
    }
}
