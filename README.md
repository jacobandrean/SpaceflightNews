# Spaceflight News App

This repository contains the code for an iOS application built using Swift and SwiftUI. The app allows users to see article, blog, and report news.

## Screen Recording Attachment
https://github.com/user-attachments/assets/b2bc2e8f-f370-4f4e-8afe-774df9b2514a
https://github.com/user-attachments/assets/4cd21718-53f8-4ece-b052-f8191dd4cf80

## Architecture Overview

The app is structured around the **MVVM (Model-View-ViewModel)** pattern and leverages **SwiftUI** to create a dynamic and responsive user interface. The architecture is designed with a **modular approach** to enhance maintainability, scalability, and testability. Below are the primary components of the architecture:

1. **NetworkModule**:
   - Responsible for all network-related operations, including making API calls and handling responses.
   - Manages network configurations, error handling, and request formatting.
   - Abstracts the underlying network logic, allowing other modules to interact with it easily.

2. **APIModule**:
   - Contains API service definitions and models for mapping API responses.
   - Defines endpoints and methods to interact with backend services.
   - Provides a clear interface for the `NewsService` to utilize the underlying network layer.

3. **InjectorModule**:
   - Implements dependency injection using a custom `@Inject` property wrapper.
   - Manages the lifecycle of shared services, enabling easy substitution of implementations (e.g., for testing).
   - Ensures that dependencies are resolved and injected appropriately into the ViewModels and other components.

4. **UtilityModule**:
   - Contains utility functions and extensions that can be reused throughout the app.

5. **SpaceflightNews**:
   - Serves as the core feature module.
