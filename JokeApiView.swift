//
//  ContentView.swift
//  api-aqsha
//
//  Created by Alif on 29/07/23.
//

import SwiftUI

struct Jokes: Hashable, Codable {
    let type: String
    let setup: String?
    let punchline: String?
    let id: Int?
}

class JokeViewModel : ObservableObject {
    @Published var jokes: Jokes = Jokes(type: "general", setup: "Welcome To Jokes Generator", punchline: "Press the button below to generate", id: nil)
    
    func fetchData() {
        guard let url = URL(string: "https://official-joke-api.appspot.com/random_joke") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Jokes.self, from: data)
                DispatchQueue.main.async {
                    self.jokes = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct JokeApiView: View {
    @StateObject var jokeViewModel = JokeViewModel()
    
    @Environment(\.presentationMode) var presentationModes
    
    var body: some View {
            VStack(spacing: 75) {
                VStack {
                    ZStack {
                        ZStack{
                            Rectangle()
                                .frame(width: 300, height: 400)
                                .foregroundColor(Color.cyan)
                                .cornerRadius(30)
                                .shadow(radius: 7)
                            VStack(spacing: -75) {
                                if let jokess = jokeViewModel.jokes.setup, let punch = jokeViewModel.jokes.punchline {
                                    Text("\(jokess)")
                                        .multilineTextAlignment(.center)
                                        .frame(width: 250, height: 200)
    //                                    .background(Color.black)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 25))
                                        .padding()
                                    Text("\(punch)")
                                        .multilineTextAlignment(.center)
    //                                    .background(Color.black)
                                        .frame(width: 250, height: 200)
                                        .padding()
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 25, weight: .bold))
                                } else {
                                    Text("Do you know what's worse than writing HTML?")
                                        .multilineTextAlignment(.center)
                                        .frame(width: 250, height: 200)
    //                                    .background(Color.black)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 25))
                                        .padding()
                                    Text("Ran out of jokes 🤣")
                                        .multilineTextAlignment(.center)
    //                                    .background(Color.black)
                                        .frame(width: 250, height: 200)
                                        .padding()
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 25, weight: .bold))
                                }
                            }
                        }
                        .navigationBarBackButtonHidden(true)
                        .navigationTitle("JOKES")
                        .navigationBarTitleDisplayMode(.inline)
                        
                        ZStack{
                            Circle()
                                .frame(width: 300, height: 100)
                                .foregroundColor(Color.yellow)
                                .offset(y: -220)
                                .shadow(radius: 5)
                            VStack{
                                if let ids = jokeViewModel.jokes.id {
                                    Text("#\(ids)")
                                        .offset(y: -220)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 25, weight: .bold))
                                } else {
                                    Text("NaN")
                                        .offset(y: -220)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 25, weight: .bold))
                                }
                                
                            }
                        }
                    }
                }
                
                VStack(spacing: 15) {
                    Button(action: {
                        jokeViewModel.fetchData()
                    },
                           label: {
                        Text("Generate Jokes")
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


struct JokeApiView_Previews: PreviewProvider {
    static var previews: some View {
        JokeApiView()
    }
}


