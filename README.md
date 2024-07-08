# MySuperApp

MySuperApp is an iOS application designed to showcase a collection of products with a featured product section, allowing users to view product details and manage their shopping cart. This README provides an overview of the app, potential enhancements, and instructions on how to run the app after cloning the repository.

## Features

- **Product Listing**: Display a list of products with a featured product section.
- **Product Details**: View detailed information about a selected product.
- **Shopping Cart**: Add products to the cart, adjust quantities, and view the total amount.
- **Product Categories**: Filter products by categories.

## Potential Enhancements

- **User Authentication**: Implement user login and registration.
- **Wishlist**: Add functionality to allow users to save products to a wishlist.
- **Improved UI/UX**: Enhance the user interface and user experience with better animations and transitions.
- **Localization**: Support multiple languages.
- **Search Functionality**: Add a search bar to allow users to search for products.
- **Push Notifications**: Notify users about new products, discounts, and promotions.
- **Refresh and Loading**: Add loadingView and fix minor reload and refresh gitches.

## Requirements

- **Xcode 15.4**
- **iOS 17.5**

## Installation

## **Clone the Repository**

   ```bash
   git clone https://github.com/danielcarpiop/MySuperApp.git
   cd MySuperApp
   ```
      
## Open the Project in Xcode

Open the `MySuperApp.xcodeproj` file in Xcode.

## Install Dependencies

Make sure to resolve any dependencies using Swift Package Manager.

## Build and Run the App

Select your target device or simulator and click on the `Run` button in Xcode or press `Cmd + R`.

## Project Structure

- **HomeViewController**: Displays the list of products and the featured product.
- **ProductDetailViewController**: Shows detailed information about a selected product.
- **CartViewController**: Manages the shopping cart, displaying added products and the total amount.
- **ViewModels**: Contains the business logic for fetching products, managing the cart, and handling state.
- **CoreDataManager**: Manages local storage for the cart items using Core Data.

## Usage

- **Viewing Products**: Browse through the product list and see featured products at the top.
- **Product Details**: Tap on any product to view its details.
- **Add to Cart**: Tap the plus button to add a product to the cart.
- **Manage Cart**: Go to the cart to see added products, adjust quantities, or remove items.
- **Filter by Category**: Use the categories view to filter products by specific categories.
