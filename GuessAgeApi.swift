//
//  GuessAgeApi.swift
//  api-aqsha
//
//  Created by Alif on 30/07/23.
//

import Foundation
import SwiftUI

struct Person: Hashable, Codable {
    let count: Int
    let name: String
    let age: Int
}

class AgeViewModel : ObservableObject {
    @Published var person : Person = Person(count: 0, name: "Mahmood", age: 79)
    
    @Published var name = ""
    
    func fetchData() {
        guard let url = URL(string: "https://api.agify.io/?name=\(name)") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Person.self, from: data)
                DispatchQueue.main.async {
                    self.person = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct GuessAgeView: View {
    @StateObject var ageViewModel = AgeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 100) {
                Text("Your name is \(ageViewModel.person.name). I guess you're \(ageViewModel.person.age) with the total count of \(ageViewModel.person.count)")
                    .padding()
                    .navigationTitle("Guess Age API")
                    .navigationBarTitleDisplayMode(.inline)
                
                TextField("Insert the name here", text: $ageViewModel.name)
                    .padding()
                    .background(Color.gray)
                    .frame(width: 300, height: 50)
                
                Button(action: {
                    ageViewModel.fetchData()
                },
                       label: {
                    Text("Guess the age")
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

struct GuessAgeApi_Previews: PreviewProvider {
    static var previews: some View {
        GuessAgeView()
    }
}


