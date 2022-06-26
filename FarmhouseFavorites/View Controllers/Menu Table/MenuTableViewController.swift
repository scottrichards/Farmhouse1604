//
//  MenuTableViewController.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/6/22.
//

import UIKit

enum MoreMenuItems : Int, CaseIterable {
    case language
    case reserve
    case info
    case account
    case contact
    case privacyPolicy
    
    func itemText() -> String {
        switch self {
  
        case .reserve:
            return "Anfrage"
        case .info:
            return "Info"
        case .language:
            return "Sprache"
        case .account:
            if UserManager.singleton.signedIn {
                return "Sign Out"
            } else {
                return "Sign In"
            }
        case .contact:
            return "Impressum"
        case .privacyPolicy:
            return "Datenschutz"
        }
    }
    
    func rightItemText() -> String? {
        switch self {
        case .language:
            return "Deutsch 🇩🇪"
        case .privacyPolicy:
            return nil
        default:
            return nil
        }
    }
}

class MenuTableViewController: UITableViewController {
    var menuItems: [MoreMenuItems] = MoreMenuItems.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: MenuHeaderView.self), bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: String(describing: MenuHeaderView.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.title = "Something"
        self.navigationController?.isNavigationBarHidden = true
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
        case .reserve: openURL(Constants.Urls.Booking)
        case .privacyPolicy: openURL(Constants.Urls.Privacy)
        case .account: openSignIn()
            
        case .info:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            if let infoVC = storyBoard.instantiateViewController(withIdentifier: "InfoVC") as? InfoViewController {
                self.navigationController?.pushViewController(infoVC, animated: true)
            }
        case .contact:
            openURL(Constants.Urls.Booking)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            if let webVC = storyBoard.instantiateViewController(withIdentifier: "WebVC") as? WebViewController {
                webVC.url = url
                self.navigationController?.pushViewController(webVC, animated: true)
            }
        }
    }
    
    func openSignIn() {
        if !UserManager.singleton.signedIn {
            let signInViewController = SigninViewController.loadFromNib()
            signInViewController.mode = .signIn
            signInViewController.modalPresentationStyle = .fullScreen
            signInViewController.delegate = self
            self.present(signInViewController, animated: true, completion: nil)
        } else {
            UserManager.singleton.signOut { success in
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let menuHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: MenuHeaderView.self)) as? MenuHeaderView else {
            return nil
        }
        menuHeader.delegate = self
        return menuHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110
    }
}

extension MenuTableViewController: SignInViewControllerDelegate {
    func doUserSignedIn() {
        tableView.reloadData()
    }
}

extension MenuTableViewController: MenuHeaderViewDelegate {
    func onGoBackToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
