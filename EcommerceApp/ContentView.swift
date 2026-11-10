//
//  ContentView.swift
//  EcommerceApp
//
//  Created by Mohit  on 07/11/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var cart: CartStore

    @State private var searchText = ""
    @State private var selectedCategory: BookCategory = .all
    @State private var showCart = false

    private let books = Book.samples

    // Adaptive columns: 2 on small iPhones, 3-4 on large iPhones/landscape, more on iPad.
    private let columns = [GridItem(.adaptive(minimum: 160, maximum: 240), spacing: 16, alignment: .top)]

    private var filteredBooks: [Book] {
        books.filter { book in
            let matchesCategory = selectedCategory == .all || book.category == selectedCategory
            let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            let matchesSearch = query.isEmpty
                || book.title.localizedCaseInsensitiveContains(query)
                || book.author.localizedCaseInsensitiveContains(query)
            return matchesCategory && matchesSearch
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    categoryBar

                    if filteredBooks.isEmpty {
                        emptyResults
                    } else {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(filteredBooks) { book in
                                NavigationLink(value: book) {
                                    BookCardView(book: book)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom)
            }
            .navigationTitle("Bookstore")
            .navigationDestination(for: Book.self) { book in
                BookDetailView(book: book)
            }
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search title or author")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    cartButton
                }
            }
            .sheet(isPresented: $showCart) {
                CartView()
            }
        }
    }

    private var categoryBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(BookCategory.allCases) { category in
                    let isSelected = category == selectedCategory
                    Button {
                        selectedCategory = category
                    } label: {
                        Text(category.rawValue)
                            .font(.subheadline.weight(.medium))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .foregroundColor(isSelected ? .white : .primary)
                            .background(Capsule().fill(isSelected ? Color.accentColor : Color(.secondarySystemBackground)))
                    }
                    .buttonStyle(.plain)
                    .accessibilityAddTraits(isSelected ? .isSelected : [])
                }
            }
            .padding(.horizontal)
        }
    }

    private var emptyResults: some View {
        VStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundColor(.secondary)
            Text("No books found")
                .font(.headline)
            Text("Try a different search or category.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
    }

    private var cartButton: some View {
        Button {
            showCart = true
        } label: {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart")
                    .font(.title3)
                if cart.totalCount > 0 {
                    Text("\(cart.totalCount)")
                        .font(.caption2.weight(.bold))
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Circle().fill(Color.red))
                        .offset(x: 10, y: -8)
                }
            }
        }
        .accessibilityLabel("Cart, \(cart.totalCount) items")
    }
}

#Preview {
    ContentView()
        .environmentObject(CartStore())
}
