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

    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    //sorted_hotels_by_price
    //sorted_hotels_by_rate
    //hotel
    //London
    //Paris
    //Cancun
    //Orlando
    //Vancouver
    //Rome
    var body: some View {
        NavigationView {
            
            VStack {
                Sliders()
                    
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
                .navigationBarTitle("Tour Location")
            }
        }
        .onAppear {
            self.dbFireStore.fetchDB(city: "Paris")
        }
    }
 
}


struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }

            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
    }

    init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
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

struct Sliders: View {
    @State public var customerValue1 : Double = 0.0
    @State public var customerValue2 : Double = 0.0
    @State public var customerValue3 : Double = 0.0
    @State public var customerValue4 : Double = 0.0
    @State private var isEditing = false
    
    var body: some View {
        VStack{
            Slider(
                value: $customerValue1,
                in: 0...10,
                step: 1,
                onEditingChanged: { editing in
                    isEditing = editing
                },
                minimumValueLabel: Text("             Free WI-Fi: 0"),
                maximumValueLabel: Text("10    ")
            ) {
                
            }
            Text("\(customerValue1)").font(.system(size: 10.0))
                .foregroundColor(isEditing ? .red : .blue)
            
            Slider(
                value: $customerValue2,
                in: 0...10,
                step: 1,
                onEditingChanged: { editing in
                    isEditing = editing
                },
                minimumValueLabel: Text("   Free Parking Lot: 0"),
                maximumValueLabel: Text("10    ")
            ) {
                
            }
            Text("\(customerValue2)").font(.system(size: 10.0))
                .foregroundColor(isEditing ? .red : .blue)
            Slider(
                value: $customerValue3,
                in: 0...10,
                step: 1,
                onEditingChanged: { editing in
                    isEditing = editing
                },
                minimumValueLabel: Text("     Swimming Pool: 0"),
                
                maximumValueLabel: Text("10    ")
            ) {
                
            }
            Text("\(customerValue3)").font(.system(size: 10.0))
                .foregroundColor(isEditing ? .red : .blue)
            
            Slider(
                value: $customerValue4,
                in: 0...10,
                step: 1,
                onEditingChanged: { editing in
                    isEditing = editing
                },
                minimumValueLabel: Text("               Breakfast: 0"),
                maximumValueLabel: Text("10    ")
            ) {
                
            }
            Text("\(customerValue4)").font(.system(size: 10.0))
                .foregroundColor(isEditing ? .red : .blue)
        }
    }
}
