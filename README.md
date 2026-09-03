# ShopSphere — POS, Billing & Inventory Management

A self-hostable Point-of-Sale system for small shops, combining a **Flutter mobile app** (frontend) with a **FastAPI + PostgreSQL backend**. The backend is designed to be run locally (e.g., on a shop's PC or a Raspberry Pi) or deployed to a server/website, with staff using the mobile app to connect to it over a network. The app speeds up day-to-day shop operations with **QR code scanning** for product recognition and **voice recognition** for hands-free customer name entry and search.

> ⚠️ **Status: Early Development.** Core screens and backend structure are scaffolded. Most business logic, database models, and API routes are not yet implemented. See [Roadmap](#roadmap) below.
>
> 🐳 **Dockerization planned.** This project is intended to ship with Docker support so anyone can pull the images (or `docker compose up`) and self-host their own instance — either locally or on a remote server. Docker files aren't added yet; see [Deployment Plans](#deployment-plans).

---

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
  - [Backend](#backend-structure)
  - [Frontend](#frontend-structure)
- [Getting Started (Development)](#getting-started-development)
  - [Backend Setup](#backend-setup)
  - [Frontend Setup](#frontend-setup)
- [Deployment Plans](#deployment-plans)
- [Roadmap](#roadmap)
- [Contributing](#contributing)

---

## Overview

ShopSphere is designed for shop owners who want a fast billing and inventory solution they can run themselves — whether that's on a machine inside the shop (local network only, no internet dependency) or on a server/website for remote access. Staff interact with the system through a **mobile app**, which talks to the **backend API**.

The app is split into three main modules:

- **Billing & Item Scan** — Create customer bills by scanning product QR codes, and track/settle due payments.
- **Inventory Management** — Add, update, and monitor stock items.
- **Finance & Analytics** — View revenue, expenses, and reports at a glance.

## Key Features

- 📷 **QR Code Product Recognition** — Scan a product's QR code to instantly add it to a bill instead of manual entry.
- 🎙️ **Voice Recognition** — Speak customer names (and other fields) instead of typing; useful for fast checkout and search.
- 🧾 **Billing System** — Generate itemized customer bills quickly.
- 💰 **Due Payment Tracking** — Track partial payments and outstanding dues per customer.
- 📦 **Inventory Management** — Maintain live stock counts and product details.
- 📊 **Finance & Analytics** — Revenue tracking and reporting (planned).
- 🔐 **Authentication** — Admin/staff login with role-based access (planned, scaffolded in `auth/`).
- 🐳 **Self-Hostable / Dockerized** — Run it locally on a shop's own hardware, or deploy it to a personal server/website (planned).

## Architecture

```
┌─────────────────────────┐        Network (LAN or Internet)        ┌──────────────────────────┐
│   Flutter Mobile App    │ <──────────────────────────────────────> │  FastAPI Backend Server  │
│  (Android/iOS device)   │              REST API (HTTP)              │  (self-hosted, Docker)  │
└─────────────────────────┘                                          └──────────┬───────────────┘
                                                                                  │
                                                                       ┌──────────▼───────────────┐
                                                                       │   PostgreSQL Database    │
                                                                       │      (own container)     │
                                                                       └───────────────────────────┘
```

- The **mobile app** is the primary UI, connecting to whichever backend instance the user points it at (local IP or a hosted domain).
- The **backend** exposes a REST API (FastAPI) and persists data in **PostgreSQL**.
- QR scanning and voice recognition happen **on-device** in the Flutter app; recognized data (product ID, customer name, etc.) is then sent to the backend.
- The eventual Docker setup will package the API and database as separate containers (see [Deployment Plans](#deployment-plans)), so anyone can spin up their own instance without manually installing Python/PostgreSQL.

## Tech Stack

**Frontend (Mobile)**
- [Flutter](https://flutter.dev/) (Dart) — cross-platform mobile UI
- `speech_to_text` — voice recognition for text fields
- QR/barcode scanning package (planned integration for product lookup)
- Material 3 design system

**Backend (Server)**
- [FastAPI](https://fastapi.tiangolo.com/) — REST API framework
- [PostgreSQL](https://www.postgresql.org/) via `psycopg2`
- `python-dotenv` — environment configuration (via a local, untracked `.env` file — see [Configuration](#configuration))
- JWT-based authentication (scaffolded under `auth/`)
- **Docker & Docker Compose** — planned, for one-command self-hosted deployment

## Project Structure

### Backend Structure

```
backend/app
├── auth
│   ├── dependency.py        # Auth dependencies (e.g., get_current_user) — WIP
│   ├── __init__.py
│   └── security.py          # Password hashing, JWT handling — WIP
├── config.py                # Loads env vars (DB_HOST, DB_PORT, DB_NAME, etc.)
├── create_admin.py          # Script to create the initial admin user — WIP
├── main.py                  # FastAPI app entrypoint & DB connection bootstrap
├── models
│   ├── bill.py               # Bill/invoice DB model — WIP
│   ├── customer.py           # Customer DB model — WIP
│   ├── product.py            # Product/inventory DB model — WIP
│   ├── transaction.py        # Payment/transaction DB model — WIP
│   └── user.py                # Staff/admin user DB model — WIP
├── routes
│   ├── auth.py                # Login/register endpoints — WIP
│   ├── bill.py                # Billing endpoints — WIP
│   ├── customer.py            # Customer CRUD endpoints — WIP
│   ├── product.py             # Product/inventory CRUD endpoints — WIP
│   └── reports.py             # Finance/analytics endpoints — WIP
├── schemas
│   ├── auth.py                 # Pydantic schemas for auth — WIP
│   ├── bill.py                 # Pydantic schemas for billing — WIP
│   ├── customer.py             # Pydantic schemas for customers — WIP
│   └── product.py              # Pydantic schemas for products — WIP
└── services
    ├── authservices.py         # Auth business logic — WIP
    ├── billing_service.py      # Billing business logic — WIP
    ├── inventory_service.py    # Inventory business logic — WIP
    └── report_service.py       # Reporting/analytics logic — WIP
```

> Files marked **WIP** currently exist as empty/skeleton files and are the next implementation targets.
>
> Not shown above (and intentionally kept out of version control): `auth.env` (secrets/DB credentials) and `__pycache__/`. See [Configuration](#configuration) and `.gitignore` below.

### Frontend Structure

```
lib
├── main.dart                          # App entrypoint & Home screen (navigation hub)
├── screens
│   ├── billing_page.dart              # Billing & Item Scan menu
│   ├── billing_pagefns
│   │   ├── billing_items_page.dart    # Create a bill (customer + items)
│   │   └── due_payment.dart           # Track & settle due payments
│   ├── finance/                       # Reserved for finance sub-screens — WIP (empty)
│   ├── finance_page.dart              # Finance & analytics overview
│   ├── inventory/                     # Reserved for inventory sub-screens — WIP (empty)
│   └── inventory_page.dart            # Inventory list & management
└── widgets
    ├── customer_name_field.dart       # Text field with voice-input (speech-to-text)
    ├── data_entry_card.dart           # Reusable two-field data entry form
    └── option_card.dart               # Reusable tappable menu card
```

**Current screen flow:**

```
HomePage
├── Billing & Item Scan (BillingPage)
│   ├── Billing Items (BillingItemsPage) → Customer Name (voice-enabled) + billing items (WIP)
│   └── Due Payments (DuePaymentPage) → Enter customer + amount paid → Payment Result
├── Inventory Management (InventoryPage) → Stock list (WIP, currently empty state only)
└── Finance & Analytics (FinancePage) → Revenue display (WIP, static placeholder)
```

## Getting Started (Development)

These steps are for running the app locally during development. A Docker-based setup for easy self-hosting is planned — see [Deployment Plans](#deployment-plans).

### Configuration

The backend reads its configuration from environment variables via a local `auth.env` file, which is **not** committed to the repository (it should be listed in `.gitignore`). Create your own copy based on the variables `config.py` expects:

| Variable | Description | Example |
|---|---|---|
| `DB_HOST` | Database host | `localhost` |
| `DB_PORT` | Database port | `5432` |
| `DB_NAME` | Database name | `shop_suite` |
| `DB_USER` | Database user | `shop_user` |
| `DB_PASSWORD` | Database password | *(your own secret)* |

A `.env.example` (with placeholder values only) should be added to the repo so new users know what to fill in — the real `auth.env` stays local/untracked.

### Backend Setup

**Requirements:** Python 3.12, PostgreSQL

```bash
cd backend/app
python3 -m venv venv
source venv/bin/activate
pip install fastapi uvicorn psycopg2-binary python-dotenv
```

Create your local `auth.env` as described in [Configuration](#configuration), then run the server:

```bash
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

Using `--host 0.0.0.0` makes the API reachable from other devices (like the mobile app) on the same local network — find your machine's local IP (e.g., `192.168.x.x`) and point the mobile app to `http://192.168.x.x:8000`.

### Frontend Setup

**Requirements:** Flutter SDK

```bash
flutter pub get
flutter run
```

Add required packages if not already present in `pubspec.yaml`:

```yaml
dependencies:
  speech_to_text: ^latest
  # QR/barcode scanning package, e.g. mobile_scanner or qr_code_scanner
```

Update the API base URL in the app's networking layer (once implemented) to point to your backend server's address — local IP for LAN hosting, or your domain if self-hosted on a server.

## Deployment Plans

The goal is to make this project **installable by anyone** with minimal setup, either for local shop use or hosted on a personal server/website. Planned approach:

- **`docker-compose.yml`** at the project root, running two services:
  - `db` — PostgreSQL container with a persistent named volume for data.
  - `api` — the FastAPI backend, built from a `Dockerfile` in `backend/app`.
- **`backend/app/Dockerfile`** — a slim Python image installing dependencies from a `requirements.txt` (not yet created) and running `uvicorn`.
- **Environment variables** for the containers supplied via a `.env` file at the project root (again, untracked — with a committed `.env.example` template).
- **Reverse proxy / hosting on a website** — for public/remote hosting, a reverse proxy (e.g., Nginx or Caddy) in front of the `api` container to handle HTTPS/TLS, so the mobile app can talk to a proper domain instead of a raw IP.
- The **Flutter app** itself isn't containerized (it's a mobile client), but its configurable API base URL will let it point at either `http://<local-ip>:8000` (LAN/local Docker host) or `https://<your-domain>` (hosted deployment).
- A **healthcheck** and **automatic DB migrations** (e.g., via Alembic) on container startup, so a fresh `docker compose up` produces a ready-to-use instance.

None of the Docker/deployment files exist yet — this section documents the intended setup so the project structure and contribution guidelines already account for it.

## Roadmap

- [ ] Implement backend DB models (`models/`) and connect them via SQLAlchemy or raw SQL
- [ ] Implement CRUD routes for products, customers, bills, and reports
- [ ] Implement authentication (`auth/`) — login, JWT issuing, role-based access
- [ ] Wire up `create_admin.py` to seed the first admin user
- [ ] Integrate QR/barcode scanning in the Flutter app for product lookup during billing
- [ ] Connect `BillingItemsPage` to product search (QR + voice) and backend bill creation
- [ ] Populate `InventoryPage` with live data from the backend, with add/edit/delete support
- [ ] Build out `FinancePage` with real analytics from `report_service.py`
- [ ] Add a `requirements.txt` / `pyproject.toml` for the backend
- [ ] Write `backend/app/Dockerfile` and a root `docker-compose.yml` (API + PostgreSQL)
- [ ] Add `.env.example` and document all required environment variables
- [ ] Set up a reverse proxy config for HTTPS-based public hosting
- [ ] Add DB migrations (Alembic) that run automatically on container startup
- [ ] Add HTTP client layer + state management (e.g., Provider/Riverpod) in the Flutter app

## Contributing

This is an early-stage personal/shop project. Suggested workflow while building out features:

1. Implement one backend module at a time (model → schema → service → route).
2. Test endpoints via FastAPI's auto-generated docs at `http://<server-ip>:8000/docs`.
3. Wire the corresponding Flutter screen to the new endpoint.
4. Keep secrets (`auth.env`, `.env`) out of version control — commit only `.env.example` templates.
5. Once Docker support lands, prefer `docker compose up` for testing full-stack changes end-to-end.

### Suggested `.gitignore` entries

```
# Backend
backend/app/auth.env
backend/app/.env
backend/app/__pycache__/
backend/app/**/__pycache__/
backend/app/venv/

# Flutter
**/build/
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
```
