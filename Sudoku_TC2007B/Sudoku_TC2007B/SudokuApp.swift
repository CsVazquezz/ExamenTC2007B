import SwiftUI

@main
struct SudokuApp: App {
    // Basic DI wiring at app level
    private let apiService: SudokuAPIService
    private let storageService: GameStorageService
    private let repository: SudokuRepository

    init() {
        // Use the default API key configured in SudokuAPIService initializer
        self.apiService = SudokuAPIService()
        self.storageService = GameStorageService()
        self.repository = SudokuRepository(apiService: apiService, storageService: storageService)
    }

    var body: some Scene {
        WindowGroup {
            let homeVM = HomeViewModel(repository: repository)
            HomeView(viewModel: homeVM)
        }
    }
}
