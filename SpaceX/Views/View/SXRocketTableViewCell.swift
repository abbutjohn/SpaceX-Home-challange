//
//  SXRocketTableViewCell.swift
//  SpaceX
//
//  Created by Abbut john on 15/06/2021.
//

import UIKit


class SXRocketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var successRateLbl: UILabel!
    
    //MARK: Assigning Data from Viewmodel

    var viewModel: RocketCellViewModel!{
        didSet {
            
            //MARK: GCD background operation
            
            if let imageUrl = URL(string: viewModel.imageURL){
                DispatchQueue.global(qos: .background).async {
                    self.imageV.donloadImage(fromUrl: imageUrl, id: self.viewModel.id)
                }
            }
            nameLbl.text = viewModel.name
            dateLbl.text = viewModel.first_flight
            successRateLbl.text = viewModel.success_rate_pct
            successRateLbl.backgroundColor = viewModel.success_color
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
