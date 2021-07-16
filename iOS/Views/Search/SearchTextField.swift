//
//  SearchTextField.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 26.05.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct SearchTextField: View {
    @State private var searchText = ""
    @EnvironmentObject var searchViewModel: SearchViewModel

    var body: some View {
        SearchBar(text: $searchText)
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.SearchAction)) { _ in
                self.searchViewModel.isLoading = true
                self.searchViewModel.searchMode = true
                self.searchViewModel.searchShowByName(self.searchText)
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.SearchCancelAction)) { _ in
                self.searchText = ""
                self.searchViewModel.searchMode = false
                self.searchViewModel.searchedShows = []
            }
            .padding(.top, 8)
            .padding(.horizontal, 4)
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            NotificationCenter.default.post(name: NSNotification.SearchAction, object: nil, userInfo: nil)
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
            NotificationCenter.default.post(name: NSNotification.SearchCancelAction, object: nil, userInfo: nil)
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.tintColor = UIColor(named: "tintColor")

        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context _: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

extension NSNotification {
    static let SearchAction = NSNotification.Name("searchAction")
    static let SearchCancelAction = NSNotification.Name("searchCancelAction")
}

// struct SearchTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchTextField()
//    }
// }
