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
    @State var city = "London"

    
    var body: some View {

        NavigationView {
            VStack{
                Text("")
                HStack{
                    Button(action: {
                        self.city = "Paris"
                        self.shuffle(city: city)
                       
                    }) {
                        Text("  Paris  ").foregroundColor(.white).background(Color.blue).cornerRadius(5)
                    }
                    
                    Button(action: {
                        self.city = "Rome"
                        self.shuffle(city: city)
                        
                    }) {
                        Text("  Rome  ").foregroundColor(.white).background(Color.blue).cornerRadius(5)
                    }
                    Button(action: {
                        self.city = "Orlando"
                        self.shuffle(city: city)
                       
                    }) {
                        Text(" Orlando ").foregroundColor(.white).background(Color.blue).cornerRadius(5)
                    }
                    Button(action: {
                        self.city = "Cancun"
                        self.shuffle(city: city)
                      
                    }) {
                        Text("  Cancun  ").foregroundColor(.white).background(Color.blue).cornerRadius(5)
                    }
                    Button(action: {
                        self.city = "Vancouver"
                        self.shuffle(city: city)
                   
                    }) {
                        Text("  Vancouver  ").foregroundColor(.white).background(Color.blue).cornerRadius(5)
                    }
                }
                
          
                List(self.dbFireStore.hotels) { post in
                    NavigationLink(destination: DetailView(url: post.link)) {
                        
                        HStack {
                            RemoteImage(url: post.thumbnailImage)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80)
                            Text(post.score).font(.system(size: 12.0))
                            Text("$" + post.price + "/night").font(.system(size: 12.0))
                            Text(post.name).font(.system(size: 12.0))
                        }
                    }
                }.onAppear{self.dbFireStore.fetchDB(city: city)}
                
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
        
        
    }
    
    func shuffle(city: String) {
        
        self.dbFireStore.fetchDB(city: city)
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
//    @Binding var index: Int
//    @Binding var isChecked: Bool
    
    
    
    var body: some View{
        VStack{
            Spacer()
            
            Text("Most people care about the following features:")
            ForEach(0..<8){index in
                ToggleView(isChecked: false, index: index, city: $city)
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


