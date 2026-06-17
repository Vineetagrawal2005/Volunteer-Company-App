# NayePankh Volunteer Companion App

A mobile companion app for NayePankh Foundation volunteers — built as part of the Mobile App Development Internship selection task (Option 2: Practical Project).

## Overview

The app lets volunteers sign up, log in, browse community events, register for them, and track their participation through an automatically computed badge system. It is built with an offline-first architecture: event data is fetched from Firestore and cached locally using Hive, so the app remains usable even without a constant internet connection.

## Problem Statement

NayePankh Foundation currently relies on scattered tools (WhatsApp groups, Google Forms) to coordinate volunteer activities. This app consolidates event discovery, registration, and volunteer recognition into a single lightweight mobile experience.

## Tech Stack

- **Flutter** — cross-platform UI framework
- **Firebase Authentication** — email/password based user accounts
- **Cloud Firestore** — source of truth for event data
- **Hive** — local on-device database used for offline caching of events, user profiles, and badge definitions
- **Provider** — app-wide state management connecting Firebase, Firestore, and Hive to the UI

## Architecture
Firestore (source of truth for events)

|  sync on load / pull-to-refresh

v

Hive (local cache — screens read from here first)

|  instant UI update

v

Provider (in-memory app state, notifies widgets)

^  writes (register / unregister for event)

|

Firestore (background sync)

Firebase Authentication handles identity only (email, password, UID). All other user data — name, phone number, and event registration history — is stored locally in Hive, keyed by the Firebase UID. This keeps the app fully functional offline after the initial data sync, since every screen reads from Hive rather than waiting on a live network call.

## Features Implemented

**Authentication** — Email/password signup and login via Firebase Auth, with friendly error messages mapped from Firebase's error codes (e.g. wrong password, email already in use, weak password). Sessions persist automatically; relaunching the app re-authenticates the user without requiring login again.

**Events** — A list of community events fetched from Firestore and cached in Hive. Each event displays a category-based image (selected automatically from a fixed tag-to-image mapping — workshop, drive, meetup, fundraiser — avoiding the need for image upload/storage entirely), title, date, location, and description. Volunteers can register or unregister for an event with one tap; the registration state updates instantly in the UI and syncs to Firestore in the background.

**Badges** — A profile section displaying the volunteer's email and phone number, alongside a set of badges (First Step, Active Volunteer, Community Pillar) that unlock automatically based on the number of events the volunteer has registered for. No manual tracking or admin intervention is required — badge status is computed live from the volunteer's own registration history.

**Offline resilience** — If Firestore is unreachable when the Events screen loads, the app falls back to whatever was last cached in Hive rather than showing an empty or broken screen. Individual malformed event records (e.g. missing fields) are skipped gracefully rather than breaking the entire list.

## Features Designed but Not Implemented (Future Scope)

Given the prototype timeframe, the following were intentionally scoped out but considered in the data model design:

- **Push notifications** — architecture would use Firebase Cloud Messaging with tokens stored per user, triggered by Cloud Functions on new events or badge unlocks.
- **Admin event management** — events are currently added directly through the Firestore console; an in-app creation/edit/delete screen was designed but not built, gated behind an admin email check.
- **Community feed** — a lightweight post/announcement feed was part of the original design but cut to focus development time on the core Events and Badges experience.

## Project Structure
lib/

├── main.dart                  Firebase/Hive initialization, badge seeding, app entry point

├── core/constants/            Colors, text styles, dimensions, tag-to-image mapping, error mapping

├── model/                     UserModel, EventModel, BadgeModel (Hive-typed data classes)

├── service/                   Direct Firebase Auth, Firestore, and Hive operations

├── repo/                      Combines services into clean operations for the app state layer

├── provider/                  AppStateProvider — central in-memory state, notifies UI on change

├── screen/                    Splash, Login, Signup, Home, Events, Badges

└── widgets/                   Reusable EventCard and BadgeCard components

## Setup Instructions (for running this project locally)

1. Clone/extract the project and run `flutter pub get`.
2. Create a Firebase project, enable Email/Password authentication, and create a Firestore database with an `events` collection (sample data structure below).
3. Run `flutterfire configure` to connect the project to your Firebase project, or replace `lib/firebase_options.dart` with your own generated file.
4. Set Firestore rules to allow public read and authenticated write on the `events` collection.
5. Run `flutter run` on a connected device or emulator.

### Sample Firestore event document structure

```json
{
  "title": "Tree Plantation Drive",
  "date": "20 June",
  "location": "Naya Raipur Central Park",
  "description": "Join us in planting saplings across the city park.",
  "tag": "drive",
  "registeredUids": []
}
```
## GitHub Link
https://github.com/Vineetagrawal2005/Volunteer-Company-App.git
## Apk Link

## Images App
<img width="519" height="1027" alt="Screenshot 2026-06-17 170825" src="https://github.com/user-attachments/assets/57c1c920-36aa-4138-8260-39688699b318" />
<img width="502" height="1032" alt="Screenshot 2026-06-17 171449" src="https://github.com/user-attachments/assets/f06afae2-7115-4485-b8ff-6308209c15a7" />
<img width="502" height="1032" alt="Screenshot 2026-06-17 171439" src="https://github.com/user-attachments/assets/8111e453-5ffb-4734-8116-aa146c603996" />
<img width="502" height="1032" alt="Screenshot 2026-06-17 171425" src="https://github.com/user-attachments/assets/6a44e54d-9b0c-4421-9705-c3f533397787" />
<img width="507" height="1031" alt="Screenshot 2026-06-17 171417" src="https://github.com/user-attachments/assets/c8bac9ac-de10-4354-a2af-cc24dcf4c50d" />

## Video App 



https://github.com/user-attachments/assets/7f96d0ed-6844-4d8d-bf5b-10d0d4261e50




## AI Assistance Disclosure

This project was built with iterative guidance from an AI assistant (Claude) for architecture planning, code review, and debugging support. All code was written and typed by the developer; the AI's role was limited to explaining concepts, reviewing code for correctness, and helping diagnose runtime issues — including a null-reference crash on app restart and a Firestore data-parsing failure, both traced and fixed through step-by-step diagnostic logging. The badge logic, event registration flow, and overall offline-first design decisions were made collaboratively, with the developer implementing and testing every piece independently.

## Author

Vineet Agrawal — Student, IIIT Naya Raipur
