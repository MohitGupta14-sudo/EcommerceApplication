//
//  BookViews.swift
//  EcommerceApp
//
//  Shared building blocks: cover placeholder, rating stars, catalog card.
//

import SwiftUI

extension Double {
    var currency: String {
        formatted(.currency(code: "USD"))
    }
}

struct BookCoverView: View {
    let book: Book

    var body: some View {
        let base = Color(hue: book.coverHue, saturation: 0.55, brightness: 0.75)
        let dark = Color(hue: book.coverHue, saturation: 0.70, brightness: 0.45)

        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(LinearGradient(colors: [base, dark], startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack(spacing: 8) {
                Image(systemName: "book.closed.fill")
                    .font(.title)
                Text(book.title)
                    .font(.footnote.weight(.semibold))
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
            .foregroundColor(.white)
            .padding(12)
        }
        .aspectRatio(2.0 / 3.0, contentMode: .fit)
        .accessibilityHidden(true)
    }
}

struct RatingView: View {
    let rating: Double
    var reviewCount: Int? = nil

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: symbol(for: star))
                    .foregroundColor(.yellow)
            }
            Text(rating.formatted(.number.precision(.fractionLength(1))))
                .font(.subheadline.weight(.medium))
                .padding(.leading, 4)
            if let reviewCount {
                Text("(\(reviewCount))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .font(.caption)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Rated \(rating.formatted(.number.precision(.fractionLength(1)))) out of 5")
    }

    private func symbol(for star: Int) -> String {
        let value = Double(star)
        if rating >= value { return "star.fill" }
        if rating >= value - 0.5 { return "star.leadinghalf.filled" }
        return "star"
    }
}

struct BookCardView: View {
    let book: Book

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            BookCoverView(book: book)
            Text(book.title)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
            Text(book.price.currency)
                .font(.subheadline.weight(.bold))
                .foregroundColor(.accentColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}
