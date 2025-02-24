# K-MovieApp

The app's architecture proposal:


```
MovieApp/
│
├── App/
│   └── MovieApp.swift
│
├── Core/
│   ├── Network/
│   │   └── NetworkManager.swift
│   ├── Storage/
│   │   └── LocalStorageManager.swift
│   └── Utilities/
│       └── Extensions.swift
│

[======= CORE BUSINESS LOGIC ======= ]

├── Domain/
│   ├── Entities/   [==== Business Models ====]
│   │   └── Movie.swift
│   ├── UseCases/   [==== Application-Specific Business Logic ====]
│   │   └── FetchMoviesUseCase.swift
│   │   └── FetchMovieDetailUseCase.swift
│   └── Repositories/ [==== Protocol-Contracts ====]
│       └── MovieRepository.swift
│
├── Data/
│   ├── API/
│   │   └── MovieAPIService.swift
│   ├── Models/  [==== Data Transfer Objects, aka. Models ====]
│   │   └── MovieDTO.swift
│   └── Repositories/  [==== Domain Layer ====]
│       └── MovieRepositoryImpl.swift
│
├── Presentation/
│   ├── ViewModels/
│   │   └── MovieListViewModel.swift
│   │   └── MovieDetailViewModel.swift
│   └── Views/
│       └── MovieListView.swift
│       └── MovieDetailView.swift
│
└── Resources/
    ├── Assets.xcassets
    └── Localizable.strings
```
