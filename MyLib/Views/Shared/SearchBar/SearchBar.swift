//
//  SearchBar.swift
//  MyLib
//
//  Created by Matej Malesevic on 05.05.22.
//

import SwiftUI
import CodeScanner

struct SearchBar: View {
    @EnvironmentObject var volumeVM: VolumeViewModel
    
    @State private var searchTerm: String = ""
    @State private var lookupError: Error? = nil
    @State private var displayError: Bool = false
    @State private var presentScanner: Bool = false
    
    var body: some View {
        HStack{
            Button {
                presentScanner.toggle()
            } label: {
                Image(systemName: "barcode.viewfinder")
                    .foregroundColor(.Primary)
                    .font(.title)
                    .padding()
            }
            TextField("ISBN Search", text: $searchTerm)
                .padding()
                .foregroundColor(Color.Primary)
                .tint(Color.Primary)
            Button {
                Task {
                    await search(for: searchTerm)
                }
            } label: {
                Image(systemName: "magnifyingglass.circle.fill")
                    .foregroundColor(.Primary)
                    .font(.title)
                    .padding()
            }
            .alert(lookupError.debugDescription, isPresented: $displayError) {
                Text("ok")
            }
        }.background(Color.Secondary)
            .sheet(isPresented: $presentScanner) {
                CodeScannerView(codeTypes: [.ean13, .ean8, .code128], simulatedData: "9783754384299") { result in
                    scannerHandler(result: result)
                }
            }
    }
    
    private func search(for term: String) async {
        do {
            try await volumeVM.lookupISBN(term)
            print(volumeVM.volumes)
        }
        catch ApiError.noResult{
            
        }
        catch let error {
            volumeVM.isSearching = false
            self.displayError = true
            self.lookupError = error
            
        }
    }
    
    private func scannerHandler(result: Result<ScanResult, ScanError>) {
        switch result {
        case .failure(let error):
            displayError = true
            lookupError = error
        case .success(let scan):
            Task {
                await search(for: scan.string)
                self.presentScanner = false
            }
        }
    }
    
    
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
            .environmentObject(VolumeViewModel(apiRequest: ApiRequest(urlSession: URLSession.shared)))
            .previewLayout(.sizeThatFits)
    }
}
