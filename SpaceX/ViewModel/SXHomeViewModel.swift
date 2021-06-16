//
//  SXHomeViewModel.swift
//  SpaceX
//
//  Created by Abbut john on 15/06/2021.
//

import UIKit

//MARK:ViewModel

class SXHomeViewModel : NSObject {
    
    var rowsPerSection: [Int] = [0]
    var rockets: [Rocket] = [] {
        didSet {
            self.rowsPerSection = [rockets.count]
            self.loadData()
        }
    }
    var loadData : (() -> ()) = {}
    var hideActivityIndicator : (() -> ()) = {}
    
    override init() {
        super.init()
        self.callFuncToGetRocketsData()
    }
    
    func callFuncToGetRocketsData() {
        
        // Test getArticles request
        APIClient.getRockets{ result in
            switch result {
            case .success(let rockets):
                self.rockets = rockets
                self.hideActivityIndicator()
            case .failure(let error):
                print(error.localizedDescription)
                self.hideActivityIndicator()
            }
        }
    }
    
    func viewModelForCell(at index: Int) -> RocketCellViewModel {
        return RocketCellViewModel(rocket: rockets[index])
    }
}

//MARK:RocketCellViewModel

struct RocketCellViewModel {
    
    let id: String
    let name: String
    let success_rate_pct: String
    let success_color: UIColor
    var first_flight: String = ""
    let active: Bool
    let imageURL:String
    let country: String
    let description: String
    let cost_per_launch: Int
    let wikipedia: String

    
    init(rocket: Rocket) {
        
        id = rocket.id
        name = rocket.name
        success_rate_pct = "\(rocket.success_rate_pct)" + "%"
        success_color = rocket.success_rate_pct >= 60 ? .systemGreen : rocket.success_rate_pct >= 30 && rocket.success_rate_pct <= 59 ? .orange : .red
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date (from: rocket.first_flight){
            first_flight = date.getFormattedDate(format: "dd MMM yyyy")
        }
        active = rocket.active
        imageURL = rocket.flickr_images.first ?? ""
        country = rocket.country
        description = rocket.description
        cost_per_launch = rocket.cost_per_launch
        wikipedia = rocket.wikipedia
        
    }
}
