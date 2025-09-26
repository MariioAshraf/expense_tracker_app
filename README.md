# expense_tracker_app

## Overview

A Flutter application to track expenses and income.  
The app allows users to add, view, and categorize transactions, with local storage using Hive.  
It includes expense validation, currency handling, and export to PDF/CSV.

---

## Architecture & Structure

- **Clean Architecture** (Domain, Data, Presentation layers).
- **Repository Pattern** for data handling.
- **Dependency Injection** using `flutter_bloc` & context.
- Local database: **Hive**.

---

## State Management

- **Bloc (flutter_bloc)** used for state management.
- Cubits/Blocs handle UI logic and interact with Repositories.

---

## API Integration

- Currently, no external API integration is used.
- Currency and transactions are handled locally.
- (Trade-off: the design allows plugging in API easily later).

---

## Pagination Strategy

- Implemented **Local Pagination with Hive**.
- Transactions are loaded in pages (e.g., 10 at a time) to improve performance instead of loading
  all at once.

---

## UI Screenshots

---

## Trade-offs & Assumptions

- No remote API: app works fully offline.
- Hive chosen for simplicity and speed.
- Pagination is local only (not API-driven).
- Currency conversion mocked/stubbed.
- Export to PDF implemented, CSV optional.

---

## How to Run the Project

1. Clone the repository
   ```bash
   git clone <repo-link>

