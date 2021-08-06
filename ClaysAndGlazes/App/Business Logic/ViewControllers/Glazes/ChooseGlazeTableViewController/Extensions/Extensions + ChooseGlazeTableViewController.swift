//
//  Extensions + ChooseGlazeTableViewController.swift
//  ClaysAndGlazes
//
//  Created by Ilya Doroshkevitch on 06.08.2021.
//

import UIKit

// MARK: Searchbar
extension ChooseGlazeTableViewController: UISearchBarDelegate {
    @available(iOS 13.0, *)
     func setupSearchBar() {
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "  Поиск..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = true
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        searchBar.searchTextField.backgroundColor = .SearchBarColor
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        searchBar.setShowsCancelButton(false, animated: true)
        tableView.tableHeaderView = searchBar
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchBar.setShowsCancelButton(true, animated: true)

        if searchBar.text == "" {
            viewModel?.isSearching = false
            tableView.reloadData()
        } else {
            viewModel?.isSearching = true
            viewModel?.filteredItemsList = []
            let searched = viewModel?.itemsList.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive) != nil
            }) ?? [""]
            viewModel?.filteredItemsList = searched
            tableView.reloadData()
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
}

// MARK: Collapse or not collapse sections
extension ChooseGlazeTableViewController: CollapsibleTableViewHeaderDelegate {
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
                //Animation.hideView(view: glazeInfoView)
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
