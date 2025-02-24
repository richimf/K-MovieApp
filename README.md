# K-MovieApp

### Abstract

The entry point of the app is the MovieApp struct, which initializes the primary ViewModel and injects it into the MovieListView (serving as the ViewController).

Following the CLEAN architecture principles, the app is structured into four main layers:
    •    Presentation:
Contains the Views and ViewModels, responsible for handling UI logic and user interactions.
    •    Domain:
Includes the UseCases, which serve the ViewModels by managing the app’s business logic and handling API fetch requests.
    •    Data:
Implements the logic for API calls, handling data retrieval and communication with external sources.
    •    Core:
Hosts core functionalities like Dependency Injection, Networking (API Endpoints), Language Utilities, and the Secrets Manager.


### App Architecture Overview:

```
MovieApp/
│
├── App/
│   └── MovieApp.swift
│
├── Core/
│   ├── DependencyInjection/
│   │   └── DependencyContainer.swift
│   ├── Network/
│   │   └── APIEndpoints.swift
│   │   └── APILanguage.swift
│   │   └── APIManager.swift
│   ├── Storage/
│   │   └── SecretsManager.swift
│   └── Utilities/
│       └── Extensions.swift
│       └── LanguageUtility.swift
│

[======= CORE BUSINESS LOGIC ======= ]

├── Data/
│   ├── API/
│   │   └── MovieAPIService.swift
│   │   └── MovieListResponse.swift
│   ├── Models/  [==== Data Transfer Objects, aka. Models ====]
│   │   └── MovieDetailDTO.swift
│   │   └── MovieDTO.swift
│   └── Repositories/  [==== Domain Layer ====]
│       └── MovieRepositoryImpl.swift
│
├── Domain/
│   ├── Entities/   [==== Business Models ====]
│   │   └── Movie.swift
│   ├── UseCases/   [==== Application-Specific Business Logic ====]
│   │   └── FetchMoviesUseCase.swift
│   │   └── FetchMovieDetailUseCase.swift
│   │   └── SearchMovieUseCase.swift
│   └── Repositories/ [==== Protocol-Contracts ====]
│       └── MovieRepository.swift
│
├── Presentation/
│   ├── ViewModels/
│   │   └── MovieDetailViewModel.swift
│   │   └── MovieListViewModel.swift
│   │   └── MovieSearchViewModel.swift
│   └── Views/
│       └── ErrorView.swift
│       └── MoviewRowView.swift
│       └── MovieListView.swift
│       └── MovieDetailView.swift
│
└── Preview Content/
│   ├── Preview Assets
│
└── Secrets     [==== Stores API keys ====]
└── Localizable [==== MultiLanguage support ====]

```


### Feature board

Every feature is listed here as Todo, In Progress or Done.
Each ticket has a prefix that stands the following:

- [ARCH] Architecture
- [FEAT] Feature
- [UI] UI Feature
- [API] API implementation

Link to the board:
https://github.com/users/richimf/projects/1/views/1
