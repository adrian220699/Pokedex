# Pokédex

A native iOS application built with Swift and UIKit for exploring Pokémon data through the PokéAPI.

The project is structured using MVVM and Clean Architecture principles, with separate Domain, Data, Core, and Presentation layers. It also uses repositories, use cases, DTOs, mappers, dependency injection, Swift Concurrency, and in-memory caching.

## 📱 Features

### Pokémon

- Paginated Pokémon list.
- Pokémon detail screen.
- Pokémon types and sprites.
- Pokémon moves.
- Spanish Pokémon descriptions.
- Encounter locations.
- Concurrent loading of Pokémon data.

### Berries

- Paginated berry list.
- Berry detail information.
- Associated item data.
- In-memory caching.

### Items

- Paginated item list.
- Item detail information.
- Item sprites and related data.
- In-memory caching.

### Regions

- Region list.
- Pokémon associated with each region.
- Paginated Pokémon by region.

## 📸 Screenshots

| Pokémon | Pokémon Detail |
| --- | --- |
| <img src="https://github.com/adrian220699/Pokedex/blob/main/Screenshots/pokemon.png" width="250"> | <img src="https://github.com/adrian220699/Pokedex/blob/main/Screenshots/pokemonDetail.png" width="250"> |

| Berries | Berries Detail |
| --- | --- |
| <img src="https://github.com/adrian220699/Pokedex/blob/main/Screenshots/berries.png" width="250"> | <img src="https://github.com/adrian220699/Pokedex/blob/main/Screenshots/berriesDetail.png" width="250"> |

| Items | Items Detail |
| --- | --- |
| <img src="https://github.com/adrian220699/Pokedex/blob/main/Screenshots/items.png" width="250"> | <img src="https://github.com/adrian220699/Pokedex/blob/main/Screenshots/itemsDetail.png" width="250"> |


| Regions | Region Pokémon |
| --- | --- |
| <img src="https://github.com/adrian220699/Pokedex/blob/main/Screenshots/regions.png" width="250"> | <img src="https://github.com/adrian220699/Pokedex/blob/main/Screenshots/regionsDetail.png" width="250"> |

## 🏗️ Architecture

The project follows a layered architecture based on MVVM and Clean Architecture principles.

```text
Presentation
     │
     ▼
  ViewModel
     │
     ▼
  Use Case
     │
     ▼
 Repository
     │
     ▼
Remote Data Source
     │
     ▼
  API Client
     │
     ▼
   PokéAPI
```

The data flow is separated into clear responsibilities:

```text
API
 ↓
DTO
 ↓
Mapper
 ↓
Domain Entity
 ↓
Use Case
 ↓
ViewModel
 ↓
ViewController
```

### Layers

#### Presentation
Contains the UI and presentation logic:

- ViewControllers
- ViewModels
- UITableView
- Navigation
- Tab bar

#### Domain
Contains the business layer and abstractions:

- Entities
- Repository protocols
- Use Cases
- Domain constants

#### Data
Handles external data sources and transformations:

- DTOs
- Mappers
- Repository implementations
- Remote Data Sources
- Caches

#### Core
Contains shared infrastructure:

- API Client
- API Endpoints
- Network Errors
- Dependency Container
- View State
- Image Loader
- Image Cache
- Application constants

## ⚡ Swift Concurrency

The project uses Swift Concurrency with `async/await` for asynchronous networking.

`withThrowingTaskGroup` is used when loading multiple resources concurrently, such as Pokémon, berries, items, and Pokémon associated with regions.

For Pokémon details, multiple API requests are started concurrently using `async let`:

```swift
async let pokemonTask = ...
async let speciesTask = ...
async let encountersTask = ...
```

This allows the application to retrieve the required data from different endpoints concurrently before mapping it into a single domain entity.

## 💾 Caching

The project implements in-memory caching for Pokémon, berries, and items.

The caches use Swift `actor`s to provide isolated access to their stored data:

```text
PokemonCache
BerryCache
ItemCache
```

Images are cached separately using `NSCache`.

The general flow is:

```text
Request
  ↓
Check Cache
  ├── HIT  → Return cached data
  │
  └── MISS → Request API
              ↓
             DTO
              ↓
            Mapper
              ↓
           Save Cache
              ↓
          Return Entity
```

## 🌐 Networking

The project contains a reusable `APIClient` built on top of `URLSession`.

The client:

- Performs asynchronous HTTP requests.
- Validates HTTP responses.
- Decodes JSON using `JSONDecoder`.
- Propagates networking and decoding errors.

The project defines centralized API endpoints for:

- Pokémon
- Pokémon Species
- Pokémon Encounters
- Characteristics
- Berries
- Items
- Regions

### API

This project uses the [PokéAPI](https://pokeapi.co/).

Base URL:

```text
https://pokeapi.co/api/v2
```

## 💉 Dependency Injection

Dependencies are assembled through a dedicated `DependencyContainer`.

For example, the Pokémon module follows this flow:

```text
PokemonRemoteDataSource
          ↓
PokemonRepositoryImpl
          ↓
GetPokemonsUseCase
          ↓
PokemonViewModel
          ↓
PokemonViewController
```

This keeps the creation of dependencies centralized and makes the different layers less coupled.

## 📂 Project Structure

```text
Pokedex/
├── Core/
│   ├── Constants/
│   ├── Network/
│   ├── State/
│   ├── Types/
│   └── Utils/
│
├── Data/
│   ├── Cache/
│   ├── DataSources/
│   │   └── Remote/
│   ├── DTO/
│   ├── Mappers/
│   └── Repositories/
│
├── Domain/
│   ├── Constants/
│   ├── Entities/
│   ├── Repositories/
│   └── UsesCases/
│
└── Presentation/
    ├── Berries/
    ├── Items/
    ├── MainTabBar/
    ├── Pokemon/
    └── Regions/
```

## 🧩 Technologies

- Swift
- UIKit
- MVVM
- Clean Architecture
- Repository Pattern
- Use Cases
- Dependency Injection
- Swift Concurrency
- `async/await`
- `withThrowingTaskGroup`
- REST API
- JSON / `Codable`
- URLSession
- Core iOS `NSCache`
- Xcode

## 🚀 Getting Started

1. Clone the repository:

```bash
git clone https://github.com/adrian220699/Pokedex.git
```

2. Open the Xcode project:

```text
Pokedex.xcodeproj
```

3. Select an iOS Simulator or compatible device.

4. Build and run the application from Xcode.

## 📚 What I Learned

This project was developed to strengthen practical knowledge of iOS architecture and asynchronous programming.

Key areas explored:

- Structuring an iOS application using Clean Architecture.
- Separating presentation, domain, and data responsibilities.
- Designing repository and use case layers.
- Transforming API DTOs into domain entities using mappers.
- Implementing dependency injection.
- Working with Swift Concurrency.
- Performing concurrent API requests with task groups and `async let`.
- Implementing in-memory caching with Swift actors.
- Handling asynchronous UI states and network errors.
- Building UIKit interfaces programmatically.

## 🔮 Future Improvements

Potential improvements for future iterations include:

- Improving loading-state feedback in the UI.
- Expanding error-state presentation.
- Adding automated tests for use cases, repositories, and mappers.
- Improving image loading and caching behavior.
- Adding additional Pokémon information and interactions.
