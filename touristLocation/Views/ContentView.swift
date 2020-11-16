//
//  ContentView.swift
//  touristLocation
//
//  Created by Lan Jin on 2020-11-15.
//

import SwiftUI

struct Experiences: Identifiable {
    var id = UUID()
    var image: String
    var name: String
    var price: String
}

struct ContentView: View {
    
    @ObservedObject var dbFireStore = DbFireStore()
    
    let experiences: [Experiences] = [Experiences(image: "property1", name: "Paris Best Kept Secrets Tour", price: "$170 per person"), Experiences(image: "property2", name: "Silent Disco Beach yoga", price: "$180 per person"), Experiences(image: "property3", name: "Miamo - Amazing view", price: "$100 per person"), Experiences(image: "property4", name: "Comfy Artist's Home", price: "$80 per person")]
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            VStack {
                //Search Bar
                SearchView().shadow(color: Color.gray.opacity(0.4), radius: 4)
                    .padding(.all)
                //ScrollView Start
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text("Tell Us What Do You Value")
                            .font(.custom("Helvetica Neue", size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black.opacity(0.9))
                        
                        //List all the hotels
                        List(self.experiences) { item in
                            NavigationLink(destination:
                                PropertyDetailsView(item: item)) {
                                PropertyView(item: item)
                                    .padding(.horizontal, -10.0)
                                    }
                                }
                                .frame(height: CGFloat(self.experiences.count) * CGFloat(270))
                            }.padding(.horizontal, 20)
                        }.environment(\.defaultMinListRowHeight, 270)
                    }.navigationBarTitle(Text("Touri").bold(), displayMode: .inline)
        }.onAppear{
            self.dbFireStore.fetchDB(city: "London")        }
    }
 
}
    

struct PropertyView: View {
    var item: Experiences
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image(self.item.image)
                    .resizable()
                    .cornerRadius(6.0)
                    .frame(height: 180)
                Text("ENTIRE HOUSE - 1 BED")
                    .foregroundColor(Color.red)
                    .font(.system(size: 10))
                .fontWeight(.medium)
                Text(self.item.name)
                    .font(.system(size: 18))
                    .fontWeight(.regular)
                Text(self.item.price)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(Color(UIColor.darkGray))
                HStack(alignment: .top) {
                    ForEach((0...4), id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 12.0, height: 12.0)
                            .foregroundColor(Color.red.opacity(0.8))
                            .padding(.horizontal, -4.0)
                    }
                    Text("5")
                        .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color(UIColor.darkGray))
                    
                }.padding(.leading, -20.0)
                .frame(width: 90.0, height: 0.0)
                
            }
            .frame(height: geometry.size.height)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


