//
//  CartStore.swift
//  EcommerceApp
//

import Combine
import SwiftUI

struct CartItem: Identifiable, Hashable {
    let book: Book
    var quantity: Int

    var id: Book.ID { book.id }
    var subtotal: Double { book.price * Double(quantity) }
}

final class CartStore: ObservableObject {
    @Published private(set) var items: [CartItem] = []

    var totalCount: Int { items.reduce(0) { $0 + $1.quantity } }
    var totalPrice: Double { items.reduce(0) { $0 + $1.subtotal } }

    func quantity(of book: Book) -> Int {
        items.first { $0.book.id == book.id }?.quantity ?? 0
    }

    func add(_ book: Book) {
        if let index = items.firstIndex(where: { $0.book.id == book.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(book: book, quantity: 1))
        }
    }

    func decrement(_ book: Book) {
        guard let index = items.firstIndex(where: { $0.book.id == book.id }) else { return }
        if items[index].quantity > 1 {
            items[index].quantity -= 1
        } else {
            items.remove(at: index)
        }
    }

    func remove(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    func clear() {
        items.removeAll()
    }
}
