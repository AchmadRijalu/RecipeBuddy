# 🍲 RecipeBuddy

Data Source: **Bundled Local JSON**
---

### 🛠 Built With

This application was built using:

- SwiftUI  
- MVVM + Repository Pattern  
- Async/Await for data loading  
- Kingfisher (image loading & caching)  
- UserDefaults (favorites persistence)

---

##  How to Run

1. **Clone the repository**
   ```bash
   git clone https://github.com/AchmadRijalu/RecipeBuddy.git
2. **Open the project in Xcode**
   ```bash
   open RecipeBuddy.xcodeproj
3. **Select the target device**  
   Choose either a **Simulator** or a **physical device**.
4. **Build & run**  
   Press **Cmd + R** in Xcode


## 📋 Requirements
- Xcode **15+**
- iOS **17+** (Deployment Target adjustable in project settings)
- Swift **5.9+**

---

## 🏗 Architecture Overview

This project follows **MVVM (Model–View–ViewModel)** with a **Repository Pattern** for clean separation of concerns.

### Model
- `RecipeModel` and related data structures.

### View
- SwiftUI screens:
  - `ListRecipeView`
  - `DetailRecipeView`
  - `FavoriteRecipeView`

### ViewModel
- Handles state, search, sorting, and favorites:
  - `ListRecipeViewModel`
  - `FavoriteRecipeViewModel`
  - `DetailRecipeViewModel`

### Repository
- `RecipeRepositoryProtocol` & `RecipeRepository` — loads recipes from local JSON using `async/await`.

##  Trade-offs

- **Local JSON** — reliable and offline access instead of API.
- **UserDefaults** — simple persistence; Core Data/SwiftData would be more scalable.
- **Kingfisher** — fast implementation but adds an external dependency.
- **MVVM over Redux/VIPER style** — less boilerplate, quicker to implement.

## ✅ What I Completed
**Level 1** of the coding test:
- Load recipes from bundled JSON.
- Display thumbnail, title, tags, and cooking time.
- Favorites functionality with persistence.
- Recipe detail view.

---

## ➕ What I’d Add with More Time
- Search by ingredients and tags.
- Sorting by cooking time or popularity.

