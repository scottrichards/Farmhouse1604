//
//  MainViewController.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 6/15/22.
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
    case About
    case Units
    case Amenities
    case Map
    case Footer
}

struct AmenitiesData {
    let image: String
    let title: String
    let description: String
}

struct SectionHeaderData {
    let title: String
    let description: String
    let image: String
}

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollingHeaderView: ScrollingTableHeaderView!
    
    let unitsTableDataArray = [
        MainTableCellData(image: "Main Farmers Home", title: "Farmers Home", quote: "“Walk to the lake”", info: "190 qm für 6 Personen", description: "Denkmalgeschützter Steintrakt auf zwei Etagen mit Terrasse"),
        MainTableCellData(image: "Main Farmers Loft", title: "Farmers Loft", quote: "“Watch the Sunrise”", info: "95 qm für 2 Personen", description: "Obergeschoss mit Balkon in Richtung Bauernhöfe im Seethal"),
        MainTableCellData(image: "Main Fishermans Home", title: "Fishermans Home", quote: "“Enjoy the Stunning Views”", info: "230 qm  für 7 Personen", description: "Auf zwei Etagen mit Terrasse zu Streuobstwiesen und Schilf"),
        MainTableCellData(image: "Main Fishermans Apartment", title: "Fishermans Apartment", quote: "“Enjoy the beautiful Sunsets”", info: "170 qm für 4 Personen", description: "Dachgeschoss mit Balkon und weitem Blick über das Schilf in Richtung See")
    ]
    
    let amenitiesTableDataArray = [
        AmenitiesData(image: "Wohnung", title: "Wohnung", description: "• W-Lan\n• Fernseher\n• Musikbox für Handy\n• WhatsApp-Service\n• 6 Beachbikes gesamt"),
        AmenitiesData(image: "Kueche", title: "Küche", description: "• 2 Herdplatten\n• 2 Kochtöpfe\n• 1 Pfanne\n• Kaffemaschine\n• Teekocher\n• Kühlschrank\n• Geschirr"),
        AmenitiesData(image: "Bad", title: "Badezimmer", description: "• Föhn\n• Bademäntel\n• Handtücher\n• Farmhouse Strandtuch"),
        AmenitiesData(image: "Haushalt", title: "Haushalt", description: "• Waschmaschine\n• Trockner\n• Bügeleisen\n• Bügelbrett")
    ]
    
    let sectionHeaderData = [
        SectionHeaderData(title:"Farmhouse 1604",
                          description:"Das Farmhouse 1604 liegt mit seinen vier großzügigen\nFerienwohnungen im Seethal – im Tal hinter dem Chiemsee.\n\nDer Grundstein für das Farmhouse wurde bereits 1604 gesetzt.\n\nUrsprünglich war dieses denkmalgeschützte Steinhaus das Bauernhaus eines Chiemsee-Fischers.",
                          image:""),
        SectionHeaderData(title: "Unsere Apartments",
                          description: "",
                          image: ""),
        SectionHeaderData(title: "Ausstattung",
                          description: "Jedes Apartment verfügt über folgende Ausstattung:",
                          image: "")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide the navigation bar
        self.navigationController?.isNavigationBarHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        scrollingHeaderView.delegate = self
        tableView.registerNib(forType: UnitTableViewCell.self)
        tableView.registerNib(forType: AmenitiesTableViewCell.self)
        tableView.register(UINib(nibName: String(describing: AmenitySectionHeader.self), bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: String(describing: AmenitySectionHeader.self))
        tableView.register(UINib(nibName: String(describing: AboutHeaderView.self), bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: String(describing: AboutHeaderView.self))
        tableView.registerNib(forType: AreaInfoTableViewCell.self)
        tableView.registerNib(forType: FooterTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.updateConstraintsIfNeeded()
        tableView.tableHeaderView?.updateConstraints()
        tableView.selectRow(at: nil, animated: false, scrollPosition: .none)
    }
}


extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return MainSections.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case MainSections.About.rawValue: return 0
        case MainSections.Units.rawValue: return unitsTableDataArray.count
        case MainSections.Amenities.rawValue: return amenitiesTableDataArray.count
        case MainSections.Map.rawValue: return 1
        case MainSections.Footer.rawValue: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            // No cells in about just a header
        case MainSections.About.rawValue:
            return UITableViewCell()
        case MainSections.Units.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UnitTableViewCell", for: indexPath)
            
            if let unitTableViewCell = cell as? UnitTableViewCell, indexPath.row < unitsTableDataArray.count {
                let unitData = unitsTableDataArray[indexPath.row]
                unitTableViewCell.populate(data: unitData)
            } else {
                cell.textLabel?.text = nil
            }

            return cell
        case MainSections.Amenities.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesTableViewCell", for: indexPath)
            
            if let amenitiesTableViewCell = cell as? AmenitiesTableViewCell, indexPath.row < unitsTableDataArray.count {
                let unitData = amenitiesTableDataArray[indexPath.row]
                amenitiesTableViewCell.populate(data: unitData)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < MainSections.allCases.count else {
            return nil
        }
        if let mainSection = MainSections(rawValue: section) {
            guard section < sectionHeaderData.count else {
                return nil
            }
            let sectionInfo = sectionHeaderData[section]
            switch mainSection {
            case .About:
                guard let aboutHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: AboutHeaderView.self)) as? AboutHeaderView else {
                    return nil
                }
                aboutHeader.populate(data: sectionInfo)
                return aboutHeader
            case .Units:
                guard let amenititySectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: AmenitySectionHeader.self)) as? AmenitySectionHeader else {
                    return nil
                }
                amenititySectionHeader.populate(data: sectionInfo)
                return amenititySectionHeader
            case .Amenities:
                guard let amenititySectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: AmenitySectionHeader.self)) as? AmenitySectionHeader else {
                    return nil
                }
                amenititySectionHeader.populate(data: sectionInfo)
                return amenititySectionHeader
            default:
                return nil
            }
        }
        return nil
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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


extension MainViewController: ScrollingTableHeaderDelegate {
    func onOpenMenu() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let menuVC = storyBoard.instantiateViewController(withIdentifier: "MenuTableVC") as? MenuTableViewController {
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
}
