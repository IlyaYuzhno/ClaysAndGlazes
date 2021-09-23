//
//  MaterialsListMainViewViewModel.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 17.09.2021.
//

import Foundation
import UIKit

class MaterialsListMainViewViewModel: MaterialsListMainViewViewModelType {

    //MARK: - Materials Statistic methods
    var statisticController: StatisticControllerType?

    init() {
        statisticController = StatisticController()
    }

    func loadStatisticData(completion: (@escaping () -> ()?)) {
        statisticController?.loadStatisticData(completion: {
            completion()
        })
    }

    // MARK: - Statistic TableView methods
    func numberOfRowsInSection(forSection section: Int, tableView: UITableView) -> Int {
        guard let statisticController = statisticController else {
            return 0
        }

        if  statisticController.statisticList.count > 0 {
            tableView.backgroundView = nil
            return statisticController.statisticList.count
        } else {
            showEmptyTablePlaceholder(tableView: tableView)
            return 0
        }
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> StatisticTableViewCellViewModelType? {
        guard let item = statisticController?.statisticList[indexPath.row] else { return nil }

        return StatisticTableViewCellViewModel(item: item, indexPath: indexPath)
    }

    func viewForHeaderInSection(tableView: UITableView) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemBackground
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .ultraLight)
        label.text = "Toп-5 материалов:"
        view.addSubview(label)
        return view
    }

    private func showEmptyTablePlaceholder(tableView: UITableView) {
        let messageLabel = UILabel(frame: CGRect(x: 20.0, y: 0, width: tableView.bounds.size.width - 40.0, height: tableView.bounds.size.height))
        messageLabel.text = "Список пока что пуст"
        messageLabel.textColor = .label
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        tableView.backgroundView = messageLabel
    }

}
