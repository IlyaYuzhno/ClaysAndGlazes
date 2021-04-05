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
    var isSearching = false
    let interactor: Interactor
    lazy var searchBar: UISearchBar = UISearchBar()
    var sections = [Section]()
    var indexPath: IndexPath?
    var clayInfoView = ClayInfoView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height + 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100), clayName: "", clayInfo: "")

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
        setUpSearchBar()

        getData()
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
        self.navigationController?.show(temperatureViewController, sender: self)
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
            showClayInfoView(clayName: filteredClaysList[indexPath.row], clayInfo: "clayInfoWhenSearch")
        } else {
            showClayInfoView(clayName: sections[indexPath.section].items[indexPath.row], clayInfo: "Представляет собой порошкообразный продукт, предназначенный для изготовления полуфарфоровых изделий методом шликерного литья в гипсовые формы.\n\nРекомендуемая температура обжига 1070-1100С°.\n\nУсадка: 4 - 9%.\n\nПорошок может быть использован в составах глазурей как источник кремнезёма и глинозёма.")  //claysInfo[indexPath.row])
        }
    }

    // MARK: - Private
    fileprivate func setupTableView() {
        tableView.addSubview(clayInfoView)
        clayInfoView.alpha = 0
        clayInfoView.delegate = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        title = "ВЫБЕРИ МАССУ"
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
extension ClaysTableViewController {
    fileprivate func getData() {
        interactor.getClays() { [weak self] response in
            let witgert = response.filter { $0.brand == "Witgert" }.map { $0.clay}
            let donbass = response.filter { $0.brand == "Donbass" }.map { $0.clay}
            let lagunaClay = response.filter { $0.brand == "LagunaClay" }.map { $0.clay}
            let labCeramica = response.filter { $0.brand == "LabCeramica" }.map { $0.clay}
            let valentineClays = response.filter { $0.brand == "ValentineClays" }.map { $0.clay}
            let konakovsky = response.filter { $0.brand == "Konakovsky" }.map { $0.clay}
            let spain = response.filter { $0.brand == "SiO2, Spain" }.map { $0.clay}

            self?.claysList = response.map { $0.clay}
            self?.filteredClaysList = self?.claysList ?? [""]
            self?.sections = [
                Section(name: "Witgert", items: witgert),
                Section(name: "Керамические массы Донбасса", items: donbass),
                Section(name: "Laguna Clay", items: lagunaClay),
                Section(name: "Lab Ceramica", items: labCeramica),
                Section(name: "Valentine Clays", items: valentineClays),
                Section(name: "Конаковский шамот", items: konakovsky),
                Section(name: "SiO2, Spain", items: spain)

            ]
            self?.tableView.reloadData()

        }

            /*
        interactor.getClaysInfo() { [weak self] response in
            self?.claysInfo = response
        }
 */

    }

}

extension ClaysTableViewController: UISearchBarDelegate {
    private func setUpSearchBar() {
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "  Поиск..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
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

extension ClaysTableViewController {
    struct Section {
        var name: String
        var items: [String]
        var collapsed: Bool

        init(name: String, items: [String], collapsed: Bool = false) {
            self.name = name
            self.items = items
            self.collapsed = collapsed
        }
    }
}

extension ClaysTableViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed

        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed: collapsed)

        // Reload the whole section
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }

}

extension ClaysTableViewController: ClayInfoViewDelegate {
    func okButtonPressed(sender: UISwipeGestureRecognizer) {

        // Hide infoView and remove blur
        Animation.hideView(view: clayInfoView)
        Animation.removeBlur()
        tableView.isScrollEnabled = true
        
  }
}
