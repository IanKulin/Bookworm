//
//  AddBookView.swift
//  Bookworm
//
//  Created by Ian Bailey on 30/10/2022.
//

import SwiftUI

struct AddBookView: View {

    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) { option in
                            Text(option)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }

                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = Date()

                        try? moc.save()
                        dismiss()
                    }
                }
                .disabled(title.isEmpty || author.isEmpty || genre.isEmpty)
            }
            .navigationTitle("Add Book")
        }
    }
}


struct AddBookView_Previews: PreviewProvider {

    static var dataController = DataController()

    static var previews: some View {
        AddBookView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}

