//
//  SXRocketTableViewCell.swift
//  SpaceX
//
//  Created by Abbut john on 15/06/2021.
//

import UIKit
import AlamofireImage


class SXRocketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var successRateLbl: UILabel!
    
    var viewModel: RocketCellViewModel!{
        didSet {
            if let imageUrl = URL(string: viewModel.imageURL){
                let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                    size: self.imageV.frame.size,
                    radius: 10.0
                )
                //GCD
                DispatchQueue.global().async {
                    self.imageV.af.setImage(
                        withURL: imageUrl,
                        placeholderImage: Image(systemName: "photo"),
                        filter: filter,
                        imageTransition: .crossDissolve(0.2)
                    )
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
