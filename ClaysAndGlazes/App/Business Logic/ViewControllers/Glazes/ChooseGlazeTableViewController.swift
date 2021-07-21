//
//  ChooseGlazeTableViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 13.04.2021.
//
import UIKit

class ChooseGlazeTableViewController: UITableViewController {

    let interactor: Interactor
    var sections = [Section]()
    var glazeList: [String] = []
    var filteredGlazeList: [String] = []
    var glazeInfo: [String] = []
    var glazeInfoDictionary: [String: String] = [:]
    let glazeInfoView = InformationView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height + 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 100), clayName: "", clayInfo: "")
    var isSearching = false
    lazy var searchBar: UISearchBar = UISearchBar()
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
        //hideKeyboardWhenTappedAround()
        getData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        isSearching ? 1 : sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? filteredGlazeList.count : sections[section].collapsed ? 0 : sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "glazeCell", for: indexPath) as! ClayCell

        isSearching ? cell.configure(item: filteredGlazeList[indexPath.row]) : cell.configure(item: sections[indexPath.section].items[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Go to next VC
        let glazeTemperatureViewController = GlazeTemperatureTableViewController(interactor: interactor)
        if isSearching {
            glazeTemperatureViewController.glaze = filteredGlazeList[indexPath.row]
        } else {
            glazeTemperatureViewController.glaze = sections[indexPath.section].items[indexPath.row]
        }
        self.navigationController?.pushViewController(glazeTemperatureViewController, animated: true)
    }

    // MARK: - Section headers setup
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "glazesListHeader") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "glazesListHeader")
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
        Animation.setBlur(view: self.view, contentView: glazeInfoView)
        self.glazeInfoView.alpha = 1
        if isSearching {
            showGlazeInfoView(glazeName: filteredGlazeList[indexPath.row], glazeInfo: glazeInfoDictionary[filteredGlazeList[indexPath.row]] ?? "")
        } else {
            showGlazeInfoView(glazeName: sections[indexPath.section].items[indexPath.row], glazeInfo: sections[indexPath.section].info[indexPath.row])
        }

        // Add pan gesture to drag info view
        let panGesture = UIPanGestureRecognizer(target: self, action:#selector(handlePanGesture(sender:)))
            glazeInfoView.addGestureRecognizer(panGesture)
    }

    // MARK: - Private
    fileprivate func setupTableView() {
        tableView.addSubview(glazeInfoView)
        glazeInfoView.alpha = 0
        glazeInfoView.delegate = self
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

    fileprivate func showGlazeInfoView(glazeName: String, glazeInfo: String) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showGlazeInfoView"), object: nil, userInfo: ["glazeName": glazeName, "glazeInfo": glazeInfo])
        Animation.showView(view: glazeInfoView)
    }
}

// MARK: - Extensions
extension ChooseGlazeTableViewController {
    fileprivate func getData() {
        interactor.getGlazesList() { [weak self] response in
            let labCeramica = response.filter { $0.brand == "Lab Ceramica" }.map { $0.glaze }
            let labCeramicaInfo = response.filter { $0.brand == "Lab Ceramica" }.map { $0.info}
            let prodesco = response.filter { $0.brand == "Prodesco" }.map { $0.glaze }
            let prodescoInfo = response.filter { $0.brand == "Prodesco" }.map { $0.info}
            let amaco = response.filter { $0.brand == "Amaco" }.map { $0.glaze }
            let amacoInfo = response.filter { $0.brand == "Amaco" }.map { $0.info}
            let terracolor = response.filter { $0.brand == "Terracolor" }.map { $0.glaze }
            let terracolorInfo = response.filter { $0.brand == "Terracolor" }.map { $0.info}
            let mayco = response.filter { $0.brand == "Mayco" }.map { $0.glaze }
            let maycoInfo = response.filter { $0.brand == "Mayco" }.map { $0.info}
            let botz = response.filter { $0.brand == "Botz" }.map { $0.glaze }
            let botzInfo = response.filter { $0.brand == "Botz" }.map { $0.info}
            let spectrum = response.filter { $0.brand == "Spectrum" }.map { $0.glaze }
            let spectrumInfo = response.filter { $0.brand == "Spectrum" }.map { $0.info}

            let subList = labCeramica + prodesco + amaco
            let subListTwo = terracolor + mayco + botz

            self?.glazeList = subList + subListTwo + spectrum
            self?.glazeInfo = response.map { $0.info}
            self?.glazeInfoDictionary = Dictionary(uniqueKeysWithValues: zip(self?.glazeList ?? [""], self?.glazeInfo ?? [""]))

            self?.filteredGlazeList = self?.glazeList ?? [""]

            // Add new section here
            self?.sections = [
                Section(name: "Lab Ceramica", items: labCeramica, info: labCeramicaInfo),
                Section(name: "Prodesco", items: prodesco, info: prodescoInfo),
                Section(name: "Amaco", items: amaco, info: amacoInfo),
                Section(name: "Terracolor", items: terracolor, info: terracolorInfo),
                Section(name: "Mayco", items: mayco, info: maycoInfo),
                Section(name: "BOTZ", items: botz, info: botzInfo),
                Section(name: "Spectrum", items: spectrum, info: spectrumInfo),
            ]
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: Searchbar
extension ChooseGlazeTableViewController: UISearchBarDelegate {
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
            filteredGlazeList = []
            filteredGlazeList = glazeList.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive) != nil
            })
            tableView.reloadData()
        }
    }
}

// MARK: Sections stuff
extension ChooseGlazeTableViewController: CollapsibleTableViewHeaderDelegate {
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
extension ChooseGlazeTableViewController: InformationViewDelegate {
    // Hide Nav bar when full screen image shown
    func hideNavigationBar(sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = true
    }

    // Show Nav bar when full screen image shown
    func showNavigationBar(sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
    }
}

// MARK: Drag and Close Info View
extension ChooseGlazeTableViewController {
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
            // If pan velocity is high do the Info View close
            if abs(velocity.y) > 500 {
                // Hide Info View...
                Animation.hideView(view: glazeInfoView)
                Animation.removeBlur()
                tableView.isScrollEnabled = true
                self.navigationController?.isNavigationBarHidden = false
                // Close full screen image
                NotificationCenter.default.post(name: Notification.Name("CloseFullScreenImageFromGlazes"), object: nil)
            }
        default:
            break
        }
    }
}
