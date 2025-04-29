//
//  ContentView.swift
//  Wishlist
//
//  Created by Vadim Vinogradov on 4/27/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wishes: [Wish]
    
    @State private var isAlertShownig: Bool = false
    @State private var newWishTitle: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishes) { wish in
                    Text(wish.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .swipeActions(edge: .leading) {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(wish)
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(wish)
                            }
                        }
                }
                
            } //: LIST
            .navigationTitle("Wishlist")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAlertShownig.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
                if wishes.isEmpty != true {
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : "")")
                    }
                }
            }
            .alert("Create a new wish", isPresented: $isAlertShownig) {
                TextField("Enter a wish", text: $newWishTitle)
                Button {
                    modelContext.insert(Wish(title: newWishTitle))
                    newWishTitle = ""
                } label: {
                    Text("Save")
                }
            }
            
            .overlay {
                if wishes.isEmpty {
                    ContentUnavailableView("My Wishlist is empty", systemImage: "heart.cicle", description: Text("No wishes yet. Add one by tapping the plus button in the top right corner."))
                }
            }
        }
    }
}

#Preview("List with Sample Data") {
    let container = try! ModelContainer(for: Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    container.mainContext.insert(Wish(title: "Buy a new car"))
    container.mainContext.insert(Wish(title: "Learn SwiftUI"))
    container.mainContext.insert(Wish(title: "Read a book"))
    container.mainContext.insert(Wish(title: "Go to the beach"))
    container.mainContext.insert(Wish(title: "Make a video"))
    
    
    return ContentView()
        .modelContainer(container)
}

#Preview("Еmptry List") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
