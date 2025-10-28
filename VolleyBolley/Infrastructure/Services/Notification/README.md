# Notification Service Architecture

## Overview

The notification system consists of three main components that work together to provide periodic notification checking and UI updates:

## Components

### 1. NotificationService
- **Purpose**: Core service that performs the actual notification checking
- **Features**:
  - Checks for notifications every 5 minutes (300 seconds)
  - Singleton pattern for global access
  - Simulates network requests with mock data
  - Handles app lifecycle (background/foreground)
  - Provides start/stop functionality

### 2. NotificationManager
- **Purpose**: Manages multiple delegates and coordinates with NotificationService
- **Features**:
  - Singleton pattern
  - Weak reference management for delegates
  - Automatic cleanup of nil delegates
  - Centralized notification distribution

### 3. Integration Points

#### MainTabBarController
- Starts/stops the notification service
- Handles app lifecycle events
- Manages service state during background/foreground transitions

#### BaseViewController
- Implements `NotificationManagerDelegate`
- Updates `navBar.updateNotifications()` when notification status changes
- Automatically registers/unregisters with NotificationManager

## Data Flow

```
NotificationService (checks every 5 min)
         ↓
NotificationManager (manages delegates)
         ↓
BaseViewController (updates navBar.updateNotifications())
         ↓
CustomNavBarView (visual updates)
```

## Usage

### Starting the Service
The service is automatically started when `MainTabBarController` loads:

```swift
// MainTabBarController.viewDidLoad()
notificationManager.startService()
```

### Receiving Updates
Any `BaseViewController` automatically receives updates:

```swift
func notificationManager(_ manager: NotificationManager, didUpdateNotificationStatus hasNewNotifications: Bool) {
    navBar.updateNotifications(hasNewNotifications)
}
```

### Manual Operations
```swift
// Check notifications immediately
NotificationManager.shared.checkNotificationsNow()

// Mark notifications as read
NotificationManager.shared.markNotificationsAsRead()

// Add/remove delegates manually
NotificationManager.shared.addDelegate(someViewController)
NotificationManager.shared.removeDelegate(someViewController)
```

## Configuration

- **Check Interval**: 5 minutes (300 seconds)
- **Simulation**: get new notification on each check
- **Mock Data**: Uses `NotificationCardViewModel.mockDataArray`

## Key Features

✅ **Automatic Lifecycle Management**: Service starts/stops with app state
✅ **Memory Safe**: Weak references prevent retention cycles  
✅ **Centralized**: Single source of truth for notification state
✅ **Extensible**: Easy to add new delegates
✅ **Testable**: Service can be manually triggered for testing
✅ **Background Friendly**: Stops checking in background to save battery
