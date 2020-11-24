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
    @State var isChecked0: Bool = false
    @State var isChecked1: Bool = false
    @State var isChecked2: Bool = false
    @State var isChecked3: Bool = false
    @State var isChecked4: Bool = false
    @State var isChecked5: Bool = false
    @State var isChecked6: Bool = false
    @State var isChecked7: Bool = false
    @State var index0: Int = 0
    @State var index1: Int = 1
    @State var index2: Int = 2
    @State var index3: Int = 3
    @State var index4: Int = 4
    @State var index5: Int = 5
    @State var index6: Int = 6
    @State var index7: Int = 7
    @State var indexList = [0,0,0,0,0,0,0,0]
    @ObservedObject var dbFireStore = DbFireStore()
    
    var body: some View{
        VStack{
          //  Spacer()
            
            Text("Most people care about the following features:")
            Toggle(isOn: self.$isChecked0, label: {
                
                switch city{
                case "Paris":
                    Text("  \(ParisFiler[index0])")
                case "Rome":
                    Text("  \(RomeFilter[index0])")
                case "Orlando":
                    Text("  \(OrlandoFilter[index0])")
                case "Cancun":
                    Text("  \(CancunFilter[index0])")
                case "Vancouver":
                    Text("  \(VancouverFilter[index0])")
                default:
                    Text("  \(ParisFiler[index0])")
                }
            }).onChange(of: isChecked0, perform: { value in
                if isChecked0 == true{
                    indexList[index0] = 1
                }else{
                    indexList[index0] = 0
                }
                print(indexList)
            })
            
            Toggle(isOn: self.$isChecked1, label: {
                
                switch city{
                case "Paris":
                    Text("  \(ParisFiler[index1])")
                case "Rome":
                    Text("  \(RomeFilter[index1])")
                case "Orlando":
                    Text("  \(OrlandoFilter[index1])")
                case "Cancun":
                    Text("  \(CancunFilter[index1])")
                case "Vancouver":
                    Text("  \(VancouverFilter[index1])")
                default:
                    Text("  \(ParisFiler[index1])")
                }
            }).onChange(of: isChecked1, perform: { value in
                if isChecked1 == true{
                    indexList[index1] = 1
                }else{
                    indexList[index1] = 0
                }
                print(indexList)
            })
            
            Toggle(isOn: self.$isChecked2, label: {
                
                switch city{
                case "Paris":
                    Text("  \(ParisFiler[index2])")
                case "Rome":
                    Text("  \(RomeFilter[index2])")
                case "Orlando":
                    Text("  \(OrlandoFilter[index2])")
                case "Cancun":
                    Text("  \(CancunFilter[index2])")
                case "Vancouver":
                    Text("  \(VancouverFilter[index2])")
                default:
                    Text("  \(ParisFiler[index2])")
                }
            }).onChange(of: isChecked2, perform: { value in
                if isChecked2 == true{
                    indexList[index2] = 1
                }else{
                    indexList[index2] = 0
                }
                print(indexList)
            })
            
            Toggle(isOn: self.$isChecked3, label: {
                
                switch city{
                case "Paris":
                    Text("  \(ParisFiler[index3])")
                case "Rome":
                    Text("  \(RomeFilter[index3])")
                case "Orlando":
                    Text("  \(OrlandoFilter[index3])")
                case "Cancun":
                    Text("  \(CancunFilter[index3])")
                case "Vancouver":
                    Text("  \(VancouverFilter[index3])")
                default:
                    Text("  \(ParisFiler[index3])")
                }
            }).onChange(of: isChecked3, perform: { value in
                if isChecked3 == true{
                    indexList[index3] = 1
                }else{
                    indexList[index3] = 0
                }
                print(indexList)
            })
            
            Toggle(isOn: self.$isChecked4, label: {
                
                switch city{
                case "Paris":
                    Text("  \(ParisFiler[index4])")
                case "Rome":
                    Text("  \(RomeFilter[index4])")
                case "Orlando":
                    Text("  \(OrlandoFilter[index4])")
                case "Cancun":
                    Text("  \(CancunFilter[index4])")
                case "Vancouver":
                    Text("  \(VancouverFilter[index4])")
                default:
                    Text("  \(ParisFiler[index4])")
                }
            }).onChange(of: isChecked4, perform: { value in
                if isChecked4 == true{
                    indexList[index4] = 1
                }else{
                    indexList[index4] = 0
                }
                print(indexList)
            })
            
            Toggle(isOn: self.$isChecked5, label: {

                switch city{
                case "Paris":
                    Text("  \(ParisFiler[index5])")
                case "Rome":
                    Text("  \(RomeFilter[index5])")
                case "Orlando":
                    Text("  \(OrlandoFilter[index5])")
                case "Cancun":
                    Text("  \(CancunFilter[index5])")
                case "Vancouver":
                    Text("  \(VancouverFilter[index5])")
                default:
                    Text("  \(ParisFiler[index5])")
                }
            }).onChange(of: isChecked5, perform: { value in
                if isChecked5 == true{
                    indexList[index5] = 1
                }else{
                    indexList[index5] = 0
                }
                print(indexList)
            })

            Toggle(isOn: self.$isChecked6, label: {

                switch city{
                case "Paris":
                    Text("  \(ParisFiler[index6])")
                case "Rome":
                    Text("  \(RomeFilter[index6])")
                case "Orlando":
                    Text("  \(OrlandoFilter[index6])")
                case "Cancun":
                    Text("  \(CancunFilter[index6])")
                case "Vancouver":
                    Text("  \(VancouverFilter[index6])")
                default:
                    Text("  \(ParisFiler[index6])")
                }
            }).onChange(of: isChecked6, perform: { value in
                if isChecked6 == true{
                    indexList[index6] = 1
                }else{
                    indexList[index6] = 0
                }
                print(indexList)
            })
//
            Toggle(isOn: self.$isChecked7, label: {

                switch city{
                case "Paris":
                    Text("  \(ParisFiler[index7])")
                case "Rome":
                    Text("  \(RomeFilter[index7])")
                case "Orlando":
                    Text("  \(OrlandoFilter[index7])")
                case "Cancun":
                    Text("  \(CancunFilter[index7])")
                case "Vancouver":
                    Text("  \(VancouverFilter[index7])")
                default:
                    Text("  \(ParisFiler[index7])")
                }
            }).onChange(of: isChecked7, perform: { value in
                if isChecked7 == true{
                    indexList[index7] = 1
                }else{
                    indexList[index7] = 0
                }
                print(indexList)
            })
            
            
            
            Button(action: {
                print("Button pressed")
                self.isPresented = false
                self.dbFireStore.findMatch(indexList: indexList, city: city)
                
            }, label: {
                Text("Confirm")
            })
            
            //Spacer()
            
      
        }
        
        }
    
        let ParisFiler = ["Bidet", "Refrigerator", "Toilet paper", "Free! WiFi is available in all areas and is free of charge.", "Coffee machine", "Kitchen", "Cleaning products", "Toilet"]
        let RomeFilter = ["Bidet", "Refrigerator", "Toilet paper", "Free! WiFi is available in all areas and is free of charge.", "Coffee machine", "Kitchen", "Cleaning products", "Toilet"]
        let OrlandoFilter = ["Bidet", "Refrigerator", "Toilet paper", "Free! WiFi is available in all areas and is free of charge.", "Coffee machine", "Kitchen", "Cleaning products", "Toilet"]
        let CancunFilter = ["Bidet", "Refrigerator", "Toilet paper", "Free! WiFi is available in all areas and is free of charge.", "Coffee machine", "Kitchen", "Cleaning products", "Toilet"]
        let VancouverFilter = ["Bidet", "Refrigerator", "Toilet paper", "Free! WiFi is available in all areas and is free of charge.", "Coffee machine", "Kitchen", "Cleaning products", "Toilet"]
}
    
   



