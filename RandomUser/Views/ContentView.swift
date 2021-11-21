//
//  ContentView.swift
//  RandomUser
//
//  Created by Noah Brauner on 11/21/21.
//

import SwiftUI

struct ContentView: View {
    @State var users = [User]()
    
    var body: some View {
        NavigationView {
            List(0..<users.count, id: \.self) { userIndex in
                let user = users[userIndex]
                HStack {
                    Text("\(user.name.title). \(user.name.first) \(user.name.last)")
                }
            }
            .navigationTitle("Random Users")
            .onAppear {
                print("appeared")
                APIManager.shared.getUsers { result in
                    switch result {
                    case .success(let users):
                        self.users = users
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
