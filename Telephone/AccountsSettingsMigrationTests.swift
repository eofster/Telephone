//
//  AccountsSettingsMigrationTests.swift
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

import UseCasesTestDoubles
import XCTest

final class AccountsSettingsMigrationTests: XCTestCase {
    func testAddsUUIDs() {
        let settings = SettingsFake()
        settings.set([[kAccountEnabled: true], [kAccountEnabled: false]], forKey: kAccounts)
        let sut = AccountsSettingsMigration(settings: settings)

        sut.execute()

        let accounts = settings.array(forKey: kAccounts) as! [[String: Any]]
        XCTAssertNotNil(UUID(uuidString: (accounts[0][kUniqueIdentifier] as! String)))
        XCTAssertNotNil(UUID(uuidString: (accounts[1][kUniqueIdentifier] as! String)))
    }

    func testDoesNotUpdateUUIDs() {
        let settings = SettingsFake()
        settings.set(
            [[kAccountEnabled: true, kUniqueIdentifier: "foo"], [kAccountEnabled: false, kUniqueIdentifier: "bar"]],
            forKey: kAccounts
        )
        let sut = AccountsSettingsMigration(settings: settings)

        sut.execute()

        let accounts = settings.array(forKey: kAccounts) as! [[String: Any]]
        XCTAssertEqual((accounts[0][kUniqueIdentifier] as! String), "foo")
        XCTAssertEqual((accounts[1][kUniqueIdentifier] as! String), "bar")
    }
}