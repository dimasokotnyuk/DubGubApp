DubDubGrub is an iOS application built with SwiftUI that enables users to discover local food & drink spots, view details, check in/out of locations, and connect with other visitors in real time. The app uses CloudKit for backend storage and sync, MapKit for location-based features, and MVVM for clean separation of concerns.

## **Core Features**

* **Map View:**

  * Displays all available locations with custom map annotations and check-in counts.
  * Shows the user’s current location and supports location-based camera positioning.

* **Location List View:**

  * Lists all venues along with avatars of currently checked-in profiles.
  * Supports pull-to-refresh and real-time updates of check-in data.

* **Location Detail View:**

  * Displays banner and square images, address, description, and quick actions (directions, website, call).
  * Allows users to check in/out.
  * Shows avatars of checked-in profiles with tap-to-view profile details.

* **Profile Management:**

  * Users can create or update their profile with name, company, bio, and avatar photo.
  * Integrated with **PhotosPicker** for image selection.
  * Bio character count validation and input feedback with icons.

* **Check-In/Out System:**

  * Tracks user presence at a location using **CloudKit references**.
  * Real-time updates across map, list, and detail views.

* **Onboarding Flow:**

  * Displays onboarding screens for first-time users.

* **Haptic Feedback:**

  * Plays success feedback for key actions like profile save and check-in.

---

## **Architecture & Technologies**

* **Language & Frameworks:**

  * Swift, SwiftUI, MapKit, CoreLocationUI, PhotosUI.

* **Data Layer:**

  * **CloudKit** for data persistence (public database).
  * Record types:

    * `DDGLocation` — stores name, address, description, images, coordinates, and contact details.
    * `DDGProfile` — stores user info, avatar, company name, bio, and check-in status.

* **Design Pattern:**

  * **MVVM** using `@Observable` / `@Bindable` for state management.
  * Separate ViewModels for Map, List, Detail, and Profile screens.

* **UI Components:**

  * **Reusable Views** like `AvatarView`, `LocationActionButton`, and custom annotation views.
  * Dynamic layout adjustments for large accessibility text sizes (switches from modal to sheet).

* **CloudKitManager:**

  * Centralized service for fetching, saving, and querying CloudKit records.
  * Supports batch save, async/await operations, cursor-based pagination, and specialized queries for check-in tracking.

* **Utilities & Constants:**

  * Centralized `Constants.swift` for record type strings, placeholder images, and device checks.
  * `AlertContext` for reusable, descriptive error and success alerts.
 
    ![](https://github.com/dimasokotnyuk/DubGubApp/blob/main/1.png?raw=true)
    ![](https://github.com/dimasokotnyuk/DubGubApp/blob/main/2.png?raw=true)
    ![](https://github.com/dimasokotnyuk/DubGubApp/blob/main/3.png?raw=true)
    ![](https://github.com/dimasokotnyuk/DubGubApp/blob/main/4.png?raw=true)
    ![](https://github.com/dimasokotnyuk/DubGubApp/blob/main/5.png?raw=true)
