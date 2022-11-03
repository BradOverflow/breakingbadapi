//
//  ContentView.swift
//  Breakingbadapi
//
//  Created by Brayden E Cramer on 11/3/22.
//



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
                    Text(quote.quote)
                        .font(.body)
                    
                }
            }.navigationTitle("Quotes")
        }
    }
    func fetchData() async{
        //create url
        guard let url = URL(string: "https://www.breakingbadapi.com/api/quotes")
        //fetch data from url
        
        //decode that data
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





