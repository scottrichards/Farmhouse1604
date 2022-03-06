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
    ),
    UnitDetailData(
        header: HeaderData(
            image: "Main Farmers Loft",
            title: "Farmers Loft",
            headline: "Ein Zuhause für Freunde und Familien.",
            description: "Wohnen und schlafen auf zei Etagen in einem denkmalgeschützen Steintrakt mit Charakter. Alte Steinböden und antike Möbel wurden durch moderne Farben neu interpretiert. Viel Raum und Platz für 6-8 Personen, zugleich gemütliches und wohliges Ambiente."),
        topImages: [ImageData(url: "Farmers-Home1", title: nil),
                    ImageData(url: "Farmers-Home2", title: nil)],
        info: "6 Personen / 190 qm Wohnfläche/ Erdgeschoss & Obergeschoss / Terrasse & Balkon\n\n3 Schlafzimmer, Wohnküche, Wohnzimmer\n\n3 Badezimmer (inkl. 1 „en suite“ Bad)\n\nAufbettung 2 Personen möglich\n\nkein Aufzug\n\nWochenpreis Sommerfrische & Zeit der Rauhnächte: 3.150 € (450 €/ Tag)\n\nWochenpreis Winterruhe: 2.700 € (385 €/ Tag)\n\n3-Tagespreis Sommerfrische & Zeit der Rauhnächte: 1.470 € (490 €/ Tag)\n\n3-Tagespreis Winterruhe: 1.350 € (450 €/ Tag)",
        bottomImages: [ImageData(url: "Farmers-Home3", title: nil),
                       ImageData(url: "Farmers-Home4", title: nil),
                       ImageData(url: "Farmers-Home5", title: nil),
                       ImageData(url: "Farmers-Home6", title: nil)]
    ),
    
    UnitDetailData(
        header: HeaderData(
            image: "Main Fishermans Home",
            title: "Fishermans Home",
            headline: "Angekommen.",
            description: "Lebendig, farbenfroh, inspirierend und romantisch. Großzügig und zugleich gemütlich. Ehemaliges Fischerzubehör vom Hof integriert in das Ambiente. Streuobstwiesen und große Schilf-Flächen von der Terrasse aus zu sehen."),
        topImages: [ImageData(url: "Fishermans-Home1", title: nil),
                    ImageData(url: "Fishermans-Home2", title: nil)],
        info: "6–8 Personen / 230 qm Wohnfläche/ Erdgeschoss & Obergeschoss / Terrasse & Balkon\n\n3 Schlafzimmer, Wohnküche, Wohnzimmer\n\n3 Badezimmer (inkl. 1 „en suite“ Bad)\n\nAufbettung 2 Personen möglich\n\nkein Aufzug\n\nWochenpreis Sommerfrische & Zeit der Rauhnächte: 3.150 € (450 €/ Tag)\n\nWochenpreis Winterruhe: 2.700 € (385 €/ Tag)\n\n3-Tagespreis Sommerfrische & Zeit der Rauhnächte: 1.470 € (490 €/ Tag)\n\n3-Tagespreis Winterruhe: 1.350 € (450 €/ Tag)",
        bottomImages: [ImageData(url: "Fishermans-Home3", title: nil),
                       ImageData(url: "Fishermans-Home4", title: nil),
                       ImageData(url: "Fishermans-Home5", title: nil),
                       ImageData(url: "Fishermans-Home6", title: nil)]
    ),
   
    UnitDetailData(
        header: HeaderData(
            image: "Main Fishermans Apartment",
            title: "Fishermans Apartment",
            headline: "Durchatmen mit Weitblick.",
            description: "Extravagant. Individuell. Farbenfroh. Loftartiges Wohn-Ess-Küchen-Zimmer auf 100 m2 mit großzügigem Balkon in Richtung Streuobstwiesen und Schilf-Flächen. Gemütliche Samt-Daybeds für die ganze Familie. Dekorative Fisch-Bilder und Seerosen aus Ton schmücken die Wände. Sunset."),
        topImages: [ImageData(url: "Fishermans-Apt1", title: nil),
                    ImageData(url: "Fishermans-Apt2", title: nil)],
        info: "4–6 Personen / 170 qm Wohnfläche/ Dachgeschoss mit hohen Decken / Balkon in Richtung See\n\nLoftartige Wohnküche mit Wohnzimmer\n2 Schlafzimmer (inkl. je 1 „en suite“ Bad), Gästetoilette\n\nAufbettung 2 Personen möglich\n\nkein Aufzug\n\nWochenpreis Sommerfrische & Zeit der Rauhnächte: 3.150 € (450 €/ Tag)\n\nWochenpreis Winterruhe: 2.700 € (385 €/ Tag)\n\n3-Tagespreis Sommerfrische & Zeit der Rauhnächte: 1.470 € (490 €/ Tag)\n\n3-Tagespreis Winterruhe: 1.350 € (450 €/ Tag)",
        bottomImages: [ImageData(url: "Fishermans-Apt3", title: nil),
                       ImageData(url: "Fishermans-Apt4", title: nil),
                       ImageData(url: "Fishermans-Apt5", title: nil),
                       ImageData(url: "Fishermans-Apt6", title: nil)]
    )
]

class UnitDetailTableViewController: UITableViewController {
    var data: UnitDetailData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(forType: DetailHeaderTableViewCell.self)
        tableView.registerNib(forType: DetailTopImagesTableViewCell.self)
        tableView.registerNib(forType: DetailInfoTableViewCell.self)
        tableView.registerNib(forType: BottomImagesTableViewCell.self)
        tableView.registerNib(forType: DetailFooterTableViewCell.self)
        self.navigationController?.isNavigationBarHidden = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderTableViewCell.shortClassName(), for: indexPath) as? DetailHeaderTableViewCell, let data = data {
                cell.data = data
                cell.populate(data: data)
                return cell
            }
            
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailTopImagesTableViewCell.shortClassName(), for: indexPath) as? DetailTopImagesTableViewCell, let data = data {
                cell.populate(data: data)
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoTableViewCell.shortClassName(), for: indexPath) as? DetailInfoTableViewCell, let data = data {
                cell.populate(data: data)
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BottomImagesTableViewCell.shortClassName(), for: indexPath) as? BottomImagesTableViewCell, let data = data {
                cell.populate(data: data)
                return cell
            }
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailFooterTableViewCell.shortClassName(), for: indexPath) as? DetailFooterTableViewCell {
                return cell
            }
        default: return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 500.0
        case 1: return 600.0
        case 2: return 550.0
        case 3: return 900.0
        case 4: return 400.0
        default: return 900.0
        }
    }

}
