//
//  ReceiptValidatingProductPurchaseEventTargetTests.swift
//  Telephone
//
//  Copyright (c) 2008-2016 Alexey Kuznetsov
//  Copyright (c) 2016 64 Characters
//
//  Telephone is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Telephone is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import XCTest
import UseCases
import UseCasesTestDoubles

class ReceiptValidatingProductPurchaseEventTargetTests: XCTestCase {
    func testCallsDidPurchaseOnOriginWhenReceiptIsValidOnDidPurchase() {
        let origin = ProductPurchaseEventTargetSpy()
        let sut = ReceiptValidatingProductPurchaseEventTarget(origin: origin, receipt: ValidProductPurchaseReceipt())
        let product = createProduct()

        sut.didPurchase(product)

        XCTAssertTrue(origin.didCallDidPurchase)
        XCTAssertEqual(origin.invokedProduct, product)
    }

    func testCallsDidFailPurchasingProductOnOriginWhenReceiptIsNotValidOnDidPurchase() {
        let origin = ProductPurchaseEventTargetSpy()
        let sut = ReceiptValidatingProductPurchaseEventTarget(origin: origin, receipt: InvalidProductPurchaseReceipt())

        sut.didPurchase(createProduct())

        XCTAssertTrue(origin.didCallDidFailPurchasingProduct)
        XCTAssertFalse(origin.invokedError.isEmpty)
    }

    func testCallsDidStartPurchasingOnOriginOnDidStartPurchase() {
        let origin = ProductPurchaseEventTargetSpy()
        let sut = ReceiptValidatingProductPurchaseEventTarget(origin: origin, receipt: InvalidProductPurchaseReceipt())
        let product = createProduct()

        sut.didStartPurchasing(product)

        XCTAssertTrue(origin.didCallDidStartPurchase)
        XCTAssertEqual(origin.invokedProduct, product)
    }

    func testCallsDidFailPurchasingProductOnOriginOnDidFailPurchasingProduct() {
        let origin = ProductPurchaseEventTargetSpy()
        let sut = ReceiptValidatingProductPurchaseEventTarget(origin: origin, receipt: InvalidProductPurchaseReceipt())
        let error = "any"

        sut.didFailPurchasingProduct(error: error)

        XCTAssertTrue(origin.didCallDidFailPurchasingProduct)
        XCTAssertEqual(origin.invokedError, error)
    }
}

private func createProduct() -> Product {
    return Product(identifier: "1", name: "product", price: NSDecimalNumber(integer: 1), localizedPrice: "$1")
}