//
//  BookDetailView.swift
//  EcommerceApp
//

import SwiftUI

struct BookDetailView: View {
    let book: Book

    @EnvironmentObject private var cart: CartStore
    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        ScrollView {
            Group {
                if sizeClass == .regular {
                    HStack(alignment: .top, spacing: 32) {
                        BookCoverView(book: book)
                            .frame(maxWidth: 320)
                        info
                    }
                } else {
                    VStack(spacing: 20) {
                        BookCoverView(book: book)
                            .frame(maxWidth: 240)
                        info
                    }
                }
            }
            .padding()
            .frame(maxWidth: 900)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) { addToCartBar }
    }

    private var info: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(book.category.rawValue.uppercased())
                .font(.caption.weight(.semibold))
                .foregroundColor(.accentColor)
            Text(book.title)
                .font(.largeTitle.bold())
            Text("by \(book.author)")
                .font(.title3)
                .foregroundColor(.secondary)
            RatingView(rating: book.rating, reviewCount: book.reviewCount)
            Text(book.price.currency)
                .font(.title2.weight(.bold))
            Divider()
            Text("About this book")
                .font(.headline)
            Text(book.description)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var addToCartBar: some View {
        VStack(spacing: 0) {
            Divider()
            Button {
                cart.add(book)
            } label: {
                let count = cart.quantity(of: book)
                Label(count == 0 ? "Add to Cart" : "Add to Cart (\(count) in cart)",
                      systemImage: "cart.badge.plus")
                    .font(.headline)
                    .frame(maxWidth: 500)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
        }
        .background(.bar)
    }
}

#Preview {
    NavigationStack {
        BookDetailView(book: Book.samples[0])
    }
    .environmentObject(CartStore())
}
