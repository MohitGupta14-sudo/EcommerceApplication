//
//  Book.swift
//  EcommerceApp
//

import Foundation

enum BookCategory: String, CaseIterable, Identifiable, Hashable {
    case all = "All"
    case fiction = "Fiction"
    case tech = "Tech"
    case science = "Science"
    case history = "History"

    var id: String { rawValue }
}

struct Book: Identifiable, Hashable {
    let id: UUID
    let title: String
    let author: String
    let price: Double
    let category: BookCategory
    let rating: Double
    let reviewCount: Int
    let description: String
    /// Hue (0...1) used to tint the generated cover placeholder.
    let coverHue: Double

    init(
        id: UUID = UUID(),
        title: String,
        author: String,
        price: Double,
        category: BookCategory,
        rating: Double,
        reviewCount: Int,
        description: String,
        coverHue: Double
    ) {
        self.id = id
        self.title = title
        self.author = author
        self.price = price
        self.category = category
        self.rating = rating
        self.reviewCount = reviewCount
        self.description = description
        self.coverHue = coverHue
    }
}

extension Book {
    static let samples: [Book] = [
        Book(title: "The Midnight Library", author: "Matt Haig", price: 14.99, category: .fiction,
             rating: 4.3, reviewCount: 2140,
             description: "Between life and death there is a library. Nora Seed gets the chance to try the lives she could have lived and discovers what truly makes a life worth living.",
             coverHue: 0.62),
        Book(title: "Project Hail Mary", author: "Andy Weir", price: 16.50, category: .fiction,
             rating: 4.8, reviewCount: 3890,
             description: "A lone astronaut wakes up on a spacecraft with no memory, and must solve an impossible problem to save humanity and Earth itself.",
             coverHue: 0.08),
        Book(title: "Dune", author: "Frank Herbert", price: 12.99, category: .fiction,
             rating: 4.6, reviewCount: 5120,
             description: "The epic story of Paul Atreides on the desert planet Arrakis, the only source of the universe's most valuable substance.",
             coverHue: 0.11),
        Book(title: "Clean Code", author: "Robert C. Martin", price: 34.95, category: .tech,
             rating: 4.4, reviewCount: 1760,
             description: "A handbook of agile software craftsmanship that teaches how to write readable, maintainable code and how to turn bad code into good code.",
             coverHue: 0.55),
        Book(title: "The Pragmatic Programmer", author: "Andrew Hunt & David Thomas", price: 39.99, category: .tech,
             rating: 4.7, reviewCount: 1430,
             description: "Timeless tips and practical advice on becoming a better and more productive developer, from tooling to career habits.",
             coverHue: 0.36),
        Book(title: "Designing Data-Intensive Applications", author: "Martin Kleppmann", price: 44.00, category: .tech,
             rating: 4.8, reviewCount: 1210,
             description: "The big ideas behind reliable, scalable and maintainable systems, covering storage, distribution, and stream processing.",
             coverHue: 0.75),
        Book(title: "Swift Programming: The Big Nerd Ranch Guide", author: "Bates, Gallagher & Sturtevant", price: 49.99, category: .tech,
             rating: 4.5, reviewCount: 640,
             description: "A hands-on introduction to Swift covering the language fundamentals and the idioms used to build modern Apple platform apps.",
             coverHue: 0.03),
        Book(title: "A Brief History of Time", author: "Stephen Hawking", price: 11.99, category: .science,
             rating: 4.5, reviewCount: 2780,
             description: "From the Big Bang to black holes, Hawking explains the biggest questions about the universe in accessible language.",
             coverHue: 0.67),
        Book(title: "Cosmos", author: "Carl Sagan", price: 15.99, category: .science,
             rating: 4.7, reviewCount: 1950,
             description: "A journey through space and time that explores how science and civilization grew up together.",
             coverHue: 0.58),
        Book(title: "Sapiens", author: "Yuval Noah Harari", price: 18.99, category: .history,
             rating: 4.6, reviewCount: 4300,
             description: "A sweeping history of humankind, from the emergence of Homo sapiens in the Stone Age to the political and technological revolutions of today.",
             coverHue: 0.95),
        Book(title: "Guns, Germs, and Steel", author: "Jared Diamond", price: 17.50, category: .history,
             rating: 4.2, reviewCount: 1520,
             description: "Why did Eurasian civilizations come to dominate the world? A Pulitzer Prize-winning look at the forces shaping human societies.",
             coverHue: 0.14),
        Book(title: "The Hobbit", author: "J.R.R. Tolkien", price: 10.99, category: .fiction,
             rating: 4.8, reviewCount: 6020,
             description: "Bilbo Baggins is swept into an epic quest to reclaim the dwarves' treasure from the dragon Smaug.",
             coverHue: 0.30)
    ]
}
