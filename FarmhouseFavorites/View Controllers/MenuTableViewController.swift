//
//  MenuTableViewController.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/6/22.
//

import UIKit

enum MoreMenuItems : Int {
    case language
    case privacyPolicy
    
    func itemText() -> String {
        switch self {
        case .language:
            return "Sprache"
        case .privacyPolicy:
            return "Privacy"
        }
    }
    
    func rightItemText() -> String? {
        switch self {
        case .language:
            return "Deutsch 🇩🇪"
        case .privacyPolicy:
            return nil
        }
    }
}

class MenuTableViewController: UITableViewController {
    var menuItems: [MoreMenuItems] = [.language, .privacyPolicy ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if let menuTableViewCell = cell as? MenuTableViewCell, indexPath.row < menuItems.count {
            let menuItem = menuItems[indexPath.row]
            menuTableViewCell.menuLabel.text = menuItem.itemText()
            menuTableViewCell.rightItemLabel.text = menuItem.rightItemText()
        } else {
            cell.textLabel?.text = nil
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        switch menuItem {
        case .language: fallthrough
        case .privacyPolicy: fallthrough
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }

}
