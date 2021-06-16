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
            VStack{
                Spacer()
                VStack{
                    Text(rocket.name)
                        .foregroundColor(.white)
                        .font(.custom("Helvetica Neue", size: 35))
                        .frame(height: 70)
                }
                Spacer()
                VStack{
                    LaunchInfo(country: rocket.country, firstLaunch: rocket.first_flight, cost_per_launch: rocket.cost_per_launch.description, status: rocket.active)
                }
                Spacer()
                VStack{
                    RemoteImage(url: rocket.imageURL)
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .cornerRadius(5)
                    Spacer()
                }
                Spacer()
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Text(rocket.description)
                            .foregroundColor(.white)
                            .font(.custom("Helvetica Neue", size: 15))
                        Spacer()
                    }
                    .padding()
                    Spacer()
                    
                }
                VStack {
                    Spacer()
                    HStack(spacing: 0) {
                        Button("https://www.wikipedia.org") {
                            if let wikiURL = URL(string: rocket.wikipedia){
                                openURL(wikiURL)
                            }
                        }
                    }
                    Spacer()
                }
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

struct LaunchInfo: View {
    
    var country : String
    var firstLaunch : String
    var cost_per_launch: String
    var status: Bool
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack{
                Spacer()
                Text("Launched on ") +
                    Text(firstLaunch) +
                    Text(" from ") +
                    Text(country) +
                    Text(" with an estimated cost of ") +
                    Text(cost_per_launch) +
                    Text("$.") +
                    Text(" Currently, the status of the mission is ") +
                    Text(status ? "Active." : "NotActive.")
                Spacer()
            }
            Spacer()
        }
        .foregroundColor(.white)
        .font(.custom("Helvetica Neue", size: 15))
        .padding(10)
    }
}
