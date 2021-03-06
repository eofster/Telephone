//
//  SimpleMusicPlayerSettingsTests.swift
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

final class SimpleMusicPlayerSettingsTests: XCTestCase {
    func testGetsFromSettingsWithExpectedKey() {
        let settings = SettingsFake()
        settings.set(true, forKey: key)
        let sut = SimpleMusicPlayerSettings(settings: settings)

        XCTAssertTrue(sut.shouldPause)
    }

    func testSetsToSettingsWithExpectedKey() {
        let settings = SettingsFake()
        let sut = SimpleMusicPlayerSettings(settings: settings)

        sut.shouldPause = true

        XCTAssertTrue(settings.bool(forKey: key))
    }

    func testRegistersDefaults() {
        let settings = SettingsFake()
        _ = SimpleMusicPlayerSettings(settings: settings)

        XCTAssertTrue(settings.registeredDefaults[key] as! Bool)
    }
}

private let key = "PauseITunes"
