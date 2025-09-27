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
![DashboardScreen](https://github-production-user-asset-6210df.s3.amazonaws.com/179972850/494626263-c02604ba-ab4e-44cc-85fd-0638d430e3f8.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250926%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250926T225342Z&X-Amz-Expires=300&X-Amz-Signature=19e2e4f2fffee05cca5cad022a6d86b7ebc49646a47ca94b711c932d6805cbad&X-Amz-SignedHeaders=host)
![AddTransactionScreen1](https://github-production-user-asset-6210df.s3.amazonaws.com/179972850/494626292-b109117a-75ae-4f4c-b9b2-5940462fcfff.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250926%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250926T225308Z&X-Amz-Expires=300&X-Amz-Signature=13172236a31ac81ffd610f3372a2cc449a9606cdacc114917bda1e2033a33894&X-Amz-SignedHeaders=host)
![AddTransactionScreen2](https://github-production-user-asset-6210df.s3.amazonaws.com/179972850/494626386-6b3773b6-7f15-4da1-aa04-7b020784bd7d.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250926%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250926T225450Z&X-Amz-Expires=300&X-Amz-Signature=30b36c5b2ce31680765b476fbc0d7fc0ef259d29573dba6e1c0d559272879c3c&X-Amz-SignedHeaders=host)
![AddTransactionScreen3](https://github.com/user-attachments/assets/8b8f1b02-d0a6-4ce7-b527-b22f522b8267)

---

## Trade-offs & Assumptions

- No remote API: app works fully offline.
- Hive chosen for simplicity and speed.
- Pagination is local only (not API-driven).
- Export to PDF implemented, CSV optional.

---

## How to Run the Project

1. Clone the repository
   ```bash
   git clone <https://github.com/MariioAshraf/expense_tracker_app>

