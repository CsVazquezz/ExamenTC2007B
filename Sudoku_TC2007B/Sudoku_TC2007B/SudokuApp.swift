import SwiftUI

@main
struct SudokuApp: App {
    // Basic DI wiring at app level
    private let apiService: SudokuAPIService
    private let storageService: GameStorageService
    private let repository: SudokuRepository

    init() {
        // TODO: Replace with secure retrieval of API key (e.g., from env or secrets)
        let apiKey = "YOUR_API_KEY_HERE"
        self.apiService = SudokuAPIService(apiKey: apiKey)
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
