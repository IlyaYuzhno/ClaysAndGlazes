//
//  ClaysTableViewController.swift
//  Clays & Glazes
//
//  Created by Ilya Doroshkevitch on 29.03.2021.
//
import UIKit

class ClaysTableViewController: UITableViewController {

    var claysList: [String] = []
    var filteredClaysList: [String] = []
    var claysInfo: [String] = []
    var claysInfoDictionary: [String: String] = [:]
    var isSearching = false
    let interactor: Interactor
    lazy var searchBar: UISearchBar = UISearchBar()
    var sections = [Section]()
    var indexPath: IndexPath?
    let clayInfoView = InformationView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height + 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 100), clayName: "", clayInfo: "")
    let startView = StartView(frame: CGRect(x: 5, y: 50, width: UIScreen.main.bounds.width - 10, height: UIScreen.main.bounds.height - 270))
    var isShown = false
    var initialCenter = CGPoint()

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
        getData()
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
        isSearching ? 1 : sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? filteredClaysList.count : sections[section].collapsed ? 0 : sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clayCell", for: indexPath) as! ClayCell
        
        isSearching ? cell.configure(item: filteredClaysList[indexPath.row]) : cell.configure(item: sections[indexPath.section].items[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Go to next VC
        let temperatureViewController = TemperatureTableViewController(interactor: interactor)
        if isSearching {
            temperatureViewController.clay = filteredClaysList[indexPath.row]
        } else {
            temperatureViewController.clay = sections[indexPath.section].items[indexPath.row]
        }
        self.navigationController?.pushViewController(temperatureViewController, animated: true)
    }

    // MARK: - Section headers setup
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(collapsed: sections[section].collapsed)
        header.section = section
        header.delegate = self
        return header
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return sections[(indexPath as NSIndexPath).section].collapsed ? 0 : UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        isSearching ? 0 : 60
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }

    // MARK: Tap on information button
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        tableView.isScrollEnabled = false
        Animation.setBlur(view: self.view, contentView: clayInfoView)
        self.clayInfoView.alpha = 1
        if isSearching {
            showClayInfoView(clayName: filteredClaysList[indexPath.row], clayInfo: claysInfoDictionary[filteredClaysList[indexPath.row]] ?? "")
        } else {
            showClayInfoView(clayName: sections[indexPath.section].items[indexPath.row], clayInfo: sections[indexPath.section].info[indexPath.row])
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
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            filteredClaysList = []
            filteredClaysList = claysList.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive) != nil
            })
            tableView.reloadData()
        }
    }
}

// MARK: Collapse or not collapse sections
extension ClaysTableViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed

        // Toggle collapse
        sections[section].collapsed = collapsed
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
