//
//  SimpleContactMatchingSettingsTests.swift
//  Telephone
//
//  Copyright © 2008-2016 Alexey Kuznetsov
//  Copyright © 2016-2021 64 Characters
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

import UseCases
import UseCasesTestDoubles
import XCTest

final class SimpleContactMatchingSettingsTests: XCTestCase {
    func testGetsLengthFromSettingsWithExpectedKey() {
        let settings = SettingsFake()
        let length = 100
        settings.set(length, forKey: key)
        let sut = SimpleContactMatchingSettings(settings: settings)

        XCTAssertEqual(sut.significantPhoneNumberLength, length)
    }

    func testRegistersDefaultLengthWithValueNine() {
        let settings = SettingsFake()
        _ = SimpleContactMatchingSettings(settings: settings)

        XCTAssertEqual(settings.registeredDefaults[key] as! Int, 9)
    }
}

private let key = "SignificantPhoneNumberLength"
