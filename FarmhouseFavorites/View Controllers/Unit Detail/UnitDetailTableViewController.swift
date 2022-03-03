//
//  UnitDetailTableViewController.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/2/22.
//

import UIKit

struct ImageData {
    let url: String
    let title: String?
}

struct HeaderData {
    let image: String
    let title: String
    let headline: String
    let description: String
}

struct UnitDetailData {
    var header: HeaderData
    var topImages = [ImageData]()
    let info: String
    var bottomImages = [ImageData]()
}

let UnitDetails: [UnitDetailData] = [
    UnitDetailData(
        header: HeaderData(
            image: "Main Farmers Home",
            title: "Farmers Home",
            headline: "Ein Zuhause für Freunde und Familien.",
            description: "Wohnen und schlafen auf zei Etagen in einem denkmalgeschützen Steintrakt mit Charakter. Alte Steinböden und antike Möbel wurden durch moderne Farben neu interpretiert. Viel Raum und Platz für 6-8 Personen, zugleich gemütliches und wohliges Ambiente."),
        topImages: [ImageData(url: "Farmers-Home1", title: nil),
                    ImageData(url: "Farmers-Home2", title: nil)],
        info: "6 Personen / 190 qm Wohnfläche/ Erdgeschoss & Obergeschoss / Terrasse & Balkon\n\n3 Schlafzimmer, Wohnküche, Wohnzimmer\n\n3 Badezimmer (inkl. 1 „en suite“ Bad)\n\nAufbettung 2 Personen möglich\n\nkein Aufzug\n\nWochenpreis Sommerfrische & Zeit der Rauhnächte: 3.150 € (450 €/ Tag)\n\nWochenpreis Winterruhe: 2.700 € (385 €/ Tag)\n\n3-Tagespreis Sommerfrische & Zeit der Rauhnächte: 1.470 € (490 €/ Tag)\n\n3-Tagespreis Winterruhe: 1.350 € (450 €/ Tag)",
        bottomImages: [ImageData(url: "Farmers-Home3", title: nil),
                       ImageData(url: "Farmers-Home4", title: nil),
                       ImageData(url: "Farmers-Home5", title: nil),
                       ImageData(url: "Farmers-Home6", title: nil)]
    )
]

class UnitDetailTableViewController: UITableViewController {
    var data: UnitDetailData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(forType: DetailHeaderTableViewCell.self)
        tableView.registerNib(forType: DetailTopImagesTableViewCell.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.section {
        case 0: if let cell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderTableViewCell.shortClassName(), for: indexPath) as? DetailHeaderTableViewCell, let data = data {
                cell.data = data
            }
            return cell
        case 1: cell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderTableViewCell.shortClassName(), for: indexPath)
        case 2: cell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderTableViewCell.shortClassName(), for: indexPath)
        case 3: cell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderTableViewCell.shortClassName(), for: indexPath)
        default: return UITableViewCell()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 600.0
        case 1: return 600.0
        case 2: return 400.0
        default: return 400.0
        }
    }

}
