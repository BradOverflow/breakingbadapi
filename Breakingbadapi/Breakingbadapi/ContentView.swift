//
//  ContentView.swift
//  Breakingbadapi
//
//  Created by Brayden E Cramer on 11/3/22.
//





//video i used
//https://www.youtube.com/watch?v=Y-GxKhLRGyE

import SwiftUI

struct Quote: Codable {
    var quote_id: Int
    var quote: String
    var author: String
    var series: String
}


struct ContentView: View {
    @State private var quotes = [Quote]()
    var body: some View {
        NavigationView{
            List(quotes, id:\.quote_id) { quote in
                VStack(alignment: .leading) {
                    Text(quote.author)
                        .font(.body)
                        .foregroundColor(Color("skyBlue"))
                    Text(quote.quote)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Quotes")
            .task {
                await fetchData()
            }
        }
    }

   

    func fetchData() async{
            //create url
        guard let url = URL(string: "https://www.breakingbadapi.com/api") else {
            print("hey man THIS URL DOES NOT WORK")
            return
        }
            //fetch data from url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //decode that data brother
            if let decodedResponse = try? JSONDecoder().decode([Quote].self, from: data) {
                quotes = decodedResponse
            }
        } catch {
            print("bad news... this data isn't valid :(")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





