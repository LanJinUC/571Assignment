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
    
    
    var body: some View {
        NavigationView {
            List(dbFireStore.sorted_hotels_by_price) { post in
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
            }
            .navigationBarTitle("Tour Location")
        }
        .onAppear {
            self.dbFireStore.fetchDB(city: "Rome")
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


