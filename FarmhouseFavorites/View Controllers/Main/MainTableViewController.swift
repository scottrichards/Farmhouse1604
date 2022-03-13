//
//  MainTableViewController.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 2/27/22.
//

import UIKit

struct MainTableCellData {
    let image: String
    let title: String
    let quote: String
    let info: String
    let description: String
}

enum MainSections: Int, CaseIterable {
    case Units
    case Map
    case Footer
}

class MainTableViewController: UITableViewController {
    let mainTableDataArray = [
        MainTableCellData(image: "Main Farmers Home", title: "Farmers Home", quote: "“Walk to the lake”", info: "190 qm für 6 Personen", description: "Denkmalgeschützter Steintrakt auf zwei Etagen mit Terrasse"),
        MainTableCellData(image: "Main Farmers Loft", title: "Farmers Loft", quote: "“Watch the Sunrise”", info: "95 qm für 2 Personen", description: "Obergeschoss mit Balkon in Richtung Bauernhöfe im Seethal"),
        MainTableCellData(image: "Main Fishermans Home", title: "Fishermans Home", quote: "“Enjoy the Stunning Views”", info: "230 qm  für 7 Personen", description: "Auf zwei Etagen mit Terrasse zu Streuobstwiesen und Schilf"),
        MainTableCellData(image: "Main Fishermans Apartment", title: "Fishermans Apartment", quote: "“Enjoy the beautiful Sunsets”", info: "170 qm für 4 Personen", description: "Dachgeschoss mit Balkon und weitem Blick über das Schilf in Richtung See")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide the navigation bar
        self.navigationController?.isNavigationBarHidden = true
        let headerFrame =  CGRect(x: 0, y: 0, width: self.view.frame.width, height: 110.0)
        print("headerFrame: \(headerFrame)")
        let headerView = MainHeaderView(frame: headerFrame)
        tableView.tableHeaderView = headerView
        self.tableView.updateConstraintsIfNeeded()
        tableView.tableHeaderView?.updateConstraints()
        
        tableView.registerNib(forType: FooterTableViewCell.self)
        tableView.registerNib(forType: AreaInfoTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return MainSections.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case MainSections.Units.rawValue: return mainTableDataArray.count
        case MainSections.Map.rawValue: return 1
        case MainSections.Footer.rawValue: return 1
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case MainSections.Units.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath)
            
            if let mainTableViewCell = cell as? MainTableViewCell, indexPath.row < mainTableDataArray.count {
                let unitData = mainTableDataArray[indexPath.row]
                mainTableViewCell.populate(data: unitData)
            } else {
                cell.textLabel?.text = nil
            }

            return cell
        case MainSections.Map.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AreaInfoTableViewCell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        case MainSections.Footer.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FooterTableViewCell", for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
//        if indexPath.section == 0 {
//            return UITableView.automaticDimension
//        } else {
//            return 400.0
//        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
//        if indexPath.section == 0 {
//            return UITableView.automaticDimension
//        } else {
//            return 400.0
//        }
    }

    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0
        } else {
            return 0.0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == MainSections.Units.rawValue else {
            return
        }
        if indexPath.row < UnitDetails.count {
            let unitData = UnitDetails[indexPath.row]
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            if let unitDetailVC = storyBoard.instantiateViewController(withIdentifier: "UnitDetailTableVC") as? UnitDetailTableViewController {
                unitDetailVC.data = unitData
                self.navigationController?.pushViewController(unitDetailVC, animated: true)
            }
        }
    }
}
