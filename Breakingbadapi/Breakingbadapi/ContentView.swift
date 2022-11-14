//
//  ContentView.swift
//  Breakingbadapi
//
//  Created by Brayden E Cramer on 11/3/22.
//


//struct for full quote contents
struct Quote: Codable {
    var quote_id: Int
    var quote: String
    var author: String
    var series: String
}
//video i used
//https://www.youtube.com/watch?v=Y-GxKhLRGyE&t=471s

import SwiftUI

struct ContentView: View {
    
    //create state variable for quotes
    
    @State private var quotes = [Quote]()
    
    // fetch data function created as async
    
    func fetchData() async {
        
        //create url
        
        guard let url = URL(string: "https://www.breakingbadapi.com/api/quotes") else
        {
            print("hey man this url doesnt work ")
            return
        }
        
        //getting the jawns
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //decode the fetched jawns from json to our quote struct jawn
            if let decodedResponse = try? JSONDecoder().decode([Quote].self, from: data) {
                quotes = decodedResponse
            }
            //catch if it doesnt work
        } catch {
            print("not valid")
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            
            //list with each jawn being titled as the quote title
            
            List(quotes, id: \.quote_id) { quote in
                VStack(alignment: .leading) {
                    Text(quote.author)
                        .font(.headline)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text(quote.quote)
                        .font(.body)
                    
                }
            }
            .navigationTitle("Quotes")
            //The task view modifier starts the unstructured async task and binds it to the view lifecycle. SwiftUI automatically cancels ongoing tasks whenever the view disappears by propagating cooperative cancellation.
            .task{
                await fetchData()
            }
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}




