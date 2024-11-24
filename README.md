# uzhavan_app
README: Uzhavan App
________________________________________
Overview
This Flutter application is a simple e-commerce app with the following functionalities:
1.	Displays a list of products with details like an image, title, and price.
2.	Allows users to purchase products, showing a confirmation dialog on purchase.
3.	Tracks purchased products and displays them on a separate "My Products" page.
4.	Features additional functionality such as a search bar , category filter tags and total price of purchased products for enhanced usability.
________________________________________
Features
Product Listing Page
•	Displays a scrollable list of products.
•	Each product includes:
o	Image: A visual representation of the product.
o	Title: Descriptive name of the product.
o	Price: The cost of the product.
o	Purchase Button: A button to buy the product.
•	Search Bar: Allows users to search for products by title.
•	Category Filter Tags: Enables users to filter products by categories.
________________________________________
Purchase Functionality
•	Clicking the Purchase button:
o	Displays a modal dialog confirming the purchase.
o	Adds the product to the "My Products" list.
________________________________________
My Products Page
•	Displays a dynamic list of purchased products.
•	Updates automatically whenever a new product is purchased.
________________________________________
 
State Management
The app uses the BLoC Pattern for state management:
•	ProductBloc: Manages the state of available and purchased products.
•	Events:
o	FetchProducts: Fetches the initial list of products.
o	SearchProducts: Filters products based on the search query.
o	FilterByCategory: Filters products by category.
o	PurchaseProduct: Handles product purchases.
•	States:
o	ProductInitial: Initial state.
o	ProductLoaded: State when products are fetched and loaded.
o	ProductPurchased: State when a product is purchased.
________________________________________
Technical Details
UI Components
•	ListView: Displays the product list and purchased products.
•	Image: Displays product images.
•	Dialog: Shows a success message on purchase.
Navigation
•	Navigator: Handles navigation between the Product Listing Page and My Products Page.
________________________________________
Mock Dataset
The app uses a hardcoded list of products, each with:
•	A unique ID.
•	Image URL.
•	Title.
•	Price.
•	category
 
________________________________________
How to Run the Project

1.	Clone the repository:
git clone https://github.com/karthikeyan0606/uzhavan_app.git
cd uzhavan_app
2.	Install dependencies:
flutter pub get
3.	Run the app:
flutter run
________________________________________
Extensions
•	Added a Search Bar for product searching.
•	Added Category Filter Tags for quick filtering of products.
•	Added a Cart Total functionality
________________________________________
Dependencies
•	Flutter SDK
•	flutter_bloc: State management.
•	provider: For dependency injection (if required).
________________________________________
Future Enhancements
1.	Add a backend integration to fetch real product data.
2.	Implement user authentication for personalized product tracking. 
