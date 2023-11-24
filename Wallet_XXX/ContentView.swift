//
//  ContentView.swift
//  Wallet_XXX
//
//  Created by Dosi Dimitrov on 23.11.23.
//
import SwiftUI
import WalletConnectV2SwiftUI
import WalletConnectModal

// eip155:1

struct ContentView: View {
 

    @State var account : String = "nnn"
  
    
    @StateObject var walletConnect = WalletConnectView(
                                                projectId: "2cd853f680bd02428bb89b1d2943f44f",
                                                name: "Swift Dapp",
                                                description: "WalletConnect to App",
                                                url: "www.walletconnect.com",
                                                icons: [""],
                                                supportedChainIds: [
                                                "eip155": ProposalNamespace(
                                                    chains: [
                                                        Blockchain("eip155:137")!,
                                                        Blockchain("eip155:80001")!,
                                                        Blockchain("eip155:42161")!,
                                                        Blockchain("eip155:8453")!,
                                                        Blockchain("eip155:10")!,
                                                        Blockchain("eip155:137")!,
                                                        Blockchain("eip155:7777777")!,
                                                        Blockchain("eip155:56")!,
                                                        Blockchain("eip155:1")!
                                                       
                                                    ],
                                                    methods: [
                                                        "personal_sign",
                                                        "eth_sendTransaction"
                                                    ], events: []
                                                )])
    
    var body: some View {
        
        
        VStack {

     
            Button {
                 walletConnect.connectWithWallet()
            } label: {
                 Text("Connect To Wallet")
            }
            .padding(.vertical, 30)
            Button {
                walletConnect.connectWithSequence{ comp in
                    
                    UIApplication.shared.open(comp)
                }
            } label: {
                 Text("connectWithSequence")
            }
            .padding(.vertical, 30)
            
            Text("account: \(account)")
        }
        .padding()
        .onChange(of: walletConnect.account, perform: { accounts in
            
            self.account = accounts.first?.address ?? "..."
            
                print("Wallet Address: ", accounts.first?.address ?? "")
        })
        .onChange(of: walletConnect.rejectedReason, perform: { reason in
                print("Wallet Connection Error", reason)
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
