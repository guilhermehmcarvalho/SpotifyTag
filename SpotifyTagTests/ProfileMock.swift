//
//  ProfileMock.swift
//  SpotifyTag
//
//  Created by Guilherme Carvalho on 07/07/2017.
//  Copyright © 2017 gboxx. All rights reserved.
//

import Foundation


class ProfileMock {
    internal func getProfileJSON() -> [String:Any] {
        return ["email":"mock@email.com",
                "id":"mockID",
                "display_name":"mock_display_name",
                "country":"PL"
        ]
    }
}
