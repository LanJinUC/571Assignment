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
    @State var isPresentingAddModel = false
    @State var city = "Paris"
    
    var body: some View {

        NavigationView {
            VStack{
                Text("")
                HStack{
                    Button(action: {
                        self.city = "Paris"
                    }) {
                        Text("  Paris  ").foregroundColor(.white).background(Color.blue).cornerRadius(5)
                    }
                    
                    Button(action: {
                        self.city = "Rome"
                    }) {
                        Text("  Rome  ").foregroundColor(.white).background(Color.blue).cornerRadius(5)
                    }
                    Button(action: {
                        self.city = "Orlando"
                    }) {
                        Text(" Orlando ").foregroundColor(.white).background(Color.blue).cornerRadius(5)
                    }
                    Button(action: {
                        self.city = "Cancun"
                    }) {
                        Text("  Cancun  ").foregroundColor(.white).background(Color.blue).cornerRadius(5)
                    }
                    Button(action: {
                        self.city = "Vancouver"
                    }) {
                        Text("  Vancouver  ").foregroundColor(.white).background(Color.blue).cornerRadius(5)
                    }
                }
                
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
      
            .navigationBarTitle("Hotel Recommends", displayMode: .inline)
            .navigationBarItems(trailing: Button(action:{
                print("Trying to open filter")
                self.isPresentingAddModel.toggle()
            }, label:{
                Text("Add Filter")
                    
            }))
            .sheet(isPresented: $isPresentingAddModel, content:{
                AddModel(isPresented: $isPresentingAddModel, city: $city)
                
            })
        }
        .onAppear {
            self.dbFireStore.fetchDB(city: city)
        }
        
    }
 
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


func convertToInt(number: Double) -> Int{
    
    return Int(number)
}



struct AddModel: View{
    @Binding var isPresented: Bool
    @Binding var city: String
    
    var body: some View{
        VStack{
            HStack{
                
            }
            Button(action: {
                print("Button pressed")
                self.isPresented = false
                self.city = "Rome"
                
            }, label: {
                Text("Confirm")
            })
            Spacer()
        }
       
        
    }
    
}


