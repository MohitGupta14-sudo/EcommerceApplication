//
//  CartView.swift
//  EcommerceApp
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject private var cart: CartStore
    @Environment(\.dismiss) private var dismiss
    @State private var showCheckoutAlert = false

    var body: some View {
        NavigationStack {
            Group {
                if cart.items.isEmpty {
                    emptyState
                } else {
                    List {
                        ForEach(cart.items) { item in
                            CartRow(item: item)
                        }
                        .onDelete(perform: cart.remove)
                    }
                    .listStyle(.plain)
                    .safeAreaInset(edge: .bottom) { totalBar }
                }
            }
            .navigationTitle("Your Cart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
            .alert("Order Placed", isPresented: $showCheckoutAlert) {
                Button("OK") {
                    cart.clear()
                    dismiss()
                }
            } message: {
                Text("Thank you! This is a demo checkout, so no payment was taken.")
            }
        }
        .presentationDetents([.medium, .large])
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "cart")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("Your cart is empty")
                .font(.headline)
            Text("Browse the catalog and add some books.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var totalBar: some View {
        VStack(spacing: 12) {
            Divider()
            HStack {
                Text("Total")
                    .font(.headline)
                Spacer()
                Text(cart.totalPrice.currency)
                    .font(.title3.weight(.bold))
            }
            Button {
                showCheckoutAlert = true
            } label: {
                Text("Checkout")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding([.horizontal, .bottom])
        .background(.bar)
    }
}

private struct CartRow: View {
    let item: CartItem
    @EnvironmentObject private var cart: CartStore

    var body: some View {
        HStack(spacing: 12) {
            BookCoverView(book: item.book)
                .frame(width: 48)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.book.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(item.book.price.currency)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer(minLength: 8)

            VStack(alignment: .trailing, spacing: 6) {
                HStack(spacing: 12) {
                    Button { cart.decrement(item.book) } label: {
                        Image(systemName: "minus.circle")
                    }
                    .accessibilityLabel("Decrease quantity")

                    Text("\(item.quantity)")
                        .font(.body.monospacedDigit())
                        .frame(minWidth: 20)

                    Button { cart.add(item.book) } label: {
                        Image(systemName: "plus.circle")
                    }
                    .accessibilityLabel("Increase quantity")
                }
                .buttonStyle(.borderless)
                .font(.title3)

                Text(item.subtotal.currency)
                    .font(.subheadline.weight(.semibold))
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let store = CartStore()
    store.add(Book.samples[0])
    store.add(Book.samples[0])
    store.add(Book.samples[3])
    return CartView().environmentObject(store)
}
