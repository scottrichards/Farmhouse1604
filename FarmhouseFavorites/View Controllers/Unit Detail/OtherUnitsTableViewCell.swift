//
//  OtherUnitsTableViewCell.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/10/22.
//

import UIKit

protocol OtherUnitsTableViewCellDelegate: AnyObject {
    func changeUnit(_ unit: UnitType)
}

class OtherUnitsTableViewCell: UITableViewCell {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view1ImageView: UIImageView!
    @IBOutlet weak var view1Label: UILabel!
    @IBOutlet weak var view2ImageView: UIImageView!
    @IBOutlet weak var view2Label: UILabel!
    @IBOutlet weak var view3ImageView: UIImageView!
    @IBOutlet weak var view3Label: UILabel!
    weak var delegate: OtherUnitsTableViewCellDelegate?
    
    var data: [UnitDetailData]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onSelectUnit1(_:)))
        self.view1.addGestureRecognizer(tapGestureRecognizer)
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(onSelectUnit2(_:)))
        self.view2.addGestureRecognizer(tapGestureRecognizer2)
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(onSelectUnit3(_:)))
        self.view3.addGestureRecognizer(tapGestureRecognizer3)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populate(data: [UnitDetailData]?) {
        guard let data = data, data.count == 3 else {
            return
        }
        self.data = data
        let unit1 = data[0]
        view1ImageView.image = UIImage(named: unit1.header.image)
        view1Label.text = unit1.header.title
        let unit2 = data[1]
        view2ImageView.image = UIImage(named: unit2.header.image)
        view2Label.text = unit2.header.title
        let unit3 = data[2]
        view3ImageView.image = UIImage(named: unit3.header.image)
        view3Label.text = unit3.header.title
    }
    
    @objc func onSelectUnit1(_ tapGesture: UITapGestureRecognizer) {
        print("on Select Unit 1")
        guard let data = data, data.count == 3 else {
            return
        }
        self.data = data
        let unit = data[0]
        delegate?.changeUnit(unit.type)
    }
    
    @objc func onSelectUnit2(_ tapGesture: UITapGestureRecognizer) {
        print("on Select Unit 2")
        guard let data = data, data.count == 3 else {
            return
        }
        self.data = data
        let unit = data[1]
        delegate?.changeUnit(unit.type)
    }
    
    @objc func onSelectUnit3(_ tapGesture: UITapGestureRecognizer) {
        print("on Select Unit 3")
        guard let data = data, data.count == 3 else {
            return
        }
        self.data = data
        let unit = data[2]
        delegate?.changeUnit(unit.type)
    }
}
