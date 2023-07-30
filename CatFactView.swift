//
//  CatFactView.swift
//  api-aqsha
//
//  Created by Alif on 30/07/23.
//

import Foundation
import SwiftUI

struct Cat: Hashable, Codable {
    let fact: String
    let length: Int
}

class CatViewModel : ObservableObject {
    @Published var cats : Cat = Cat(fact: "Give you reason to love cat", length: 90)
    
    func fetchData() {
        guard let url = URL(string: "https://catfact.ninja/fact") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Cat.self, from: data)
                DispatchQueue.main.async {
                    self.cats = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct CatFactView: View {
    @StateObject var catViewModel = CatViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 100) {
                Text("Fun fact about cat: \n \(catViewModel.cats.fact)")
                    .navigationBarTitle("Cat Facts API", displayMode: .inline)
                
                Button(action: {
                    catViewModel.fetchData()
                },
                       label: {
                    Text("Give me fact!")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
        }
        
    }
}
