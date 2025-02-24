//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//
import SwiftUI

class MovieListViewModel: ObservableObject {

    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var isPaginating: Bool = false
    @Published var errorMessage: String?

    private let fetchMoviesUseCase: FetchMoviesUseCase
    private var currentPage: Int = 1
    private var canLoadMore: Bool = true

    init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
        fetchMovies()
    }

    // MARK: - Fetch Initial Movies
    func fetchMovies() {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        fetchMoviesUseCase.execute(page: currentPage, language: LanguageUtility.getDeviceAPILanguage()) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.canLoadMore = !movies.isEmpty
                case .failure(let error):
                    self.errorMessage = self.parseError(error)
                }
            }
        }
    }

    // MARK: - Load More for Pagination
    func loadMoreMovies() {
        guard !isPaginating && canLoadMore else { return }

        isPaginating = true
        currentPage += 1

        fetchMoviesUseCase.execute(page: currentPage, language: LanguageUtility.getDeviceAPILanguage()) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isPaginating = false
                switch result {
                case .success(let movies):
                    self.movies.append(contentsOf: movies)
                    self.canLoadMore = !movies.isEmpty
                case .failure(let error):
                    self.errorMessage = self.parseError(error)
                }
            }
        }
    }

    // MARK: - Parse Error for UI
    private func parseError(_ error: Error) -> String {
        let nsError = error as NSError
        if nsError.domain == NSURLErrorDomain {
            switch nsError.code {
            case NSURLErrorNotConnectedToInternet:
                return "You appear to be offline. Please check your connection."
            case NSURLErrorTimedOut:
                return "The request timed out. Please try again."
            default:
                return "An unexpected network error occurred."
            }
        }
        return error.localizedDescription
    }
}
