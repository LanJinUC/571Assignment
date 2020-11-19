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
    
   

    
    @State var showMenu = false
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        MenuView()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }
                    .gesture(drag)
            }
                .navigationBarTitle("Side Menu", displayMode: .inline)
                .navigationBarItems(leading: (
                    Button(action: {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                ))
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


struct MainView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
               self.showMenu = true
            }
        }) {
            Text("Show Menu")
        }
    }
}




//struct HotelsView: View {
//    @ObservedObject var dbFireStore = DbFireStore()
//    
//    var body: some View {
//        NavigationView {
//            List(dbFireStore.hotels) { post in
//                NavigationLink(destination: DetailView(url: post.link)) {
//                    
//                    HStack {
//                        RemoteImage(url: post.thumbnailImage)
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 100)
//                        Text(post.score).font(.system(size: 12.0))
//                        Text("$" + post.price + "/night").font(.system(size: 12.0))
//                        Text(post.name).font(.system(size: 12.0))
//                    }
//                }
//            }
//            
//        }
//        .onAppear {
//            self.dbFireStore.fetchDB(city: "Paris")
//        }
//    }
//}
