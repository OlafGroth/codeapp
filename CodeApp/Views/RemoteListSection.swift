//
//  RemoteList.swift
//  Code
//
//  Created by Ken Chung on 11/4/2022.
//

import SwiftUI

struct RemoteListSection: View {
    let hosts: [RemoteHost]

    let onRemoveHost: (RemoteHost) -> Void
    let onConnectToHost: (RemoteHost, () -> Void) async throws -> Void
    let onConnectToHostWithCredentials: (RemoteHost, URLCredential) async throws -> Void

    var body: some View {
        Section(header: Text("Remotes")) {
            if hosts.isEmpty {
                DescriptionText("You don't have any saved remote.")
            }

            ForEach(hosts, id: \.url) { host in
                RemoteHostCell(
                    host: host,
                    onRemove: {
                        onRemoveHost(host)
                    },
                    onConnect: { onRequestCredentials in
                        try await onConnectToHost(host, onRequestCredentials)
                    },
                    onConnectWithCredentials: { cred in
                        try await onConnectToHostWithCredentials(host, cred)
                    }
                )
            }
        }
    }
}
