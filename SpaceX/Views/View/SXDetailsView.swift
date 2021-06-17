//
//  SXDetailsView.swift
//  SpaceX
//
//  Created by Abbut john on 15/06/2021.
//

import SwiftUI
import Foundation

struct SXDetailsView: View {
    
    @State var rocket: RocketCellViewModel
    @Environment(\.openURL) var openURL
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(rocket.success_color),.black]), startPoint: .topLeading, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            ScrollView(.vertical) {
                    VStack {
                        VStack{
                            Text(rocket.name)
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                                .font(.title)
                                .frame(height: 100)
                        }
                        HStack{
                            LaunchInfo(country: rocket.country, firstLaunch: rocket.first_flight, cost_per_launch: rocket.cost_per_launch.description, status: rocket.active)
                        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
                        VStack{
                            RemoteImage(url: rocket.imageURL)
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 300)
                                .cornerRadius(5)
                        }
                        VStack{
                            HStack{
                                Text(rocket.description)
                                    .foregroundColor(.white)
                                    .font(.custom("Helvetica Neue", size: 17))
                                Spacer()
                            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                           
                        }
                        Spacer()
                        VStack {
                            HStack(spacing: 0) {
                                Button("https://www.wikipedia.org") {
                                    if let wikiURL = URL(string: rocket.wikipedia){
                                        openURL(wikiURL)
                                    }
                                }
                            }
                            
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
               }            
        }
    }
   
}

struct SXDetailsView_Previews: PreviewProvider {
    @State static var rocketValue = RocketCellViewModel(rocket: Rocket(id: "abc", name: "abc", success_rate_pct: 0, first_flight: "abc", active: false, flickr_images: ["abc"], country: "abc", description: "abc", cost_per_launch: 0, wikipedia: "abc"))
    
    static var previews: some View {
        SXDetailsView(rocket: rocketValue)
    }
}

//MARK: Custum Views


struct LaunchInfo: View {
    
    var country : String
    var firstLaunch : String
    var cost_per_launch: String
    var status: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Launched on ") +
                Text(firstLaunch) +
                Text(" from ") +
                Text(country) +
                Text(" with an estimated cost of ") +
                Text(cost_per_launch) +
                Text("$.") +
                Text(" Currently, the status of the mission is ") +
                Text(status ? "active." : "not-active.")
         }
        .foregroundColor(.white)
        .font(.custom("Helvetica Neue", size: 17))
    }
}


