//
//  HotelsView.swift
//  touristLocation
//
//  Created by Lan Jin on 2020-11-19.
//

import SwiftUI

struct HotelsView: View {
 
    @ObservedObject var dbFireStore = DbFireStore()
    
    var body: some View {
        NavigationView {
            List(dbFireStore.hotels) { post in
                NavigationLink(destination: DetailView(url: post.link)) {
                    
                    HStack {
                        RemoteImage(url: post.thumbnailImage)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        Text(post.score).font(.system(size: 12.0))
                        Text("$" + post.price + "/night").font(.system(size: 12.0))
                        Text(post.name).font(.system(size: 12.0))
                    }
                }
            }
            
        }
        .onAppear {
            self.dbFireStore.fetchDB(city: "Paris")
        }
    }
}


