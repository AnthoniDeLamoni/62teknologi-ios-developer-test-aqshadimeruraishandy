//
//  DogApiView.swift
//  api-aqsha
//
//  Created by Alif on 30/07/23.
//

import Foundation
import SwiftUI

struct Dog: Hashable, Codable {
    let message: String
    let status: String
}

class DogViewModel : ObservableObject {
    @Published var dogs : Dog = Dog(message: "https://media.istockphoto.com/id/1135504943/photo/cute-beagle-dog-sitting-on-a-brown-welcome-mat.jpg?s=612x612&w=0&k=20&c=C_diArGt7wGheThdVVK9fbc1PAYX2mC1c_9AYPgfKJA=", status: "success")
    
    func fetchData() {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Dog.self, from: data)
                DispatchQueue.main.async {
                    self.dogs = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct DogApiView: View {
    @StateObject var dogViewModel = DogViewModel()
    
    @Environment(\.presentationMode) var presentationModes
    
    var body: some View {
            VStack(spacing: 100) {
                AsyncImage(url: URL(string: dogViewModel.dogs.message)) {image in
                    
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.blue)
                }
                .frame(width: 500, height: 250)
                
                // AsyncImage(url: URL(string: dogViewModel.dogs.message))
                .navigationBarBackButtonHidden(true)
                .navigationTitle("DOG IMAGES")
                .navigationBarTitleDisplayMode(.inline)
                
                VStack(spacing: 15) {
                    Button(action: {
                        dogViewModel.fetchData()
                    },
                           label: {
                        Text("Summon cute little dog")
                            .bold()
                            .frame(width: 300, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    })
                    
                    Button("Back to main menu") {
                        presentationModes.wrappedValue.dismiss()
                    }
                }
            }
        }
        
    }


struct DogApiView_Previews: PreviewProvider {
    static var previews: some View {
        DogApiView()
    }
}
