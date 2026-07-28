# 🏦 Finora — Enterprise Financial Engine & Tracker

**Finora** is a high-precision, enterprise-grade financial management application built with **Flutter** & **Dart**. Designed with strict adherence to **Clean Architecture** and **Domain-Driven Design (DDD)** principles, Finora focuses on data integrity, immutability, auditability, and absolute financial precision.

---

## 🌟 Core Concepts & Architectural Principles

Unlike standard CRUD applications, Finora implements a **Rich Domain Model** where core business invariants, validations, and financial rules are fully encapsulated within the Domain layer.

### 🏛️ 1. Domain-Driven Design (DDD)
* **Aggregate Root (`User` / `Account`):** Manages entity lifecycles and enforces consistency boundaries across financial transactions.
* **Entities:** `User`, `Account`, and polymorphic `Transaction` entities (`Income`, `Expense`).
* **Value Objects:** Eliminates *Primitive Obsession* by wrapping core raw types into immutable Value Objects with strict encapsulation (e.g., `Money`, `UserName`, `PersonName`).
* **Domain Invariants:** Objects cannot exist in an invalid state. Validation occurs upon object creation using custom domain exceptions.

### 🔒 2. Data Integrity & Immutability
* **Immutable Entities:** All domain classes use strict `final` fields and private constructors.
* **Sentinel Pattern:** Advanced `copyWith` implementation utilizing a `static const Object sentinel` to explicitly differentiate between *omitting a parameter* vs *explicitly setting a nullable field to `null`*.
* **Domain Validation Pipeline:** Enforces invariants via dedicated validators (`TitleValidator`, `TransactionIdValidator`, `CreatedAtValidator`).

### ⚖️ 3. Audit-Ready Financial Calculations
* **Polymorphism in Transactions:** Financial effects are calculated via polymorphic behaviors where `Income` yields positive effects and `Expense` yields negative effects.
* **Fast-Path vs. Audit-Path Design:**
  * **Fast-Path:** Ultra-fast balance adjustments for standard addition and deletion operations.
  * **Audit-Path:** A full re-calculation engine triggered during transaction modifications to guarantee absolute transaction trail accuracy and prevent balance drift.

---

## 🏗️ Clean Architecture Overview

Finora follows a decoupled 4-layer architecture:

```text
       +--------------------------------------------------+
       |               Presentation Layer                 |
       |         (UI Widgets, State Management)           |
       +------------------------+-------------------------+
                                |
                                v
       +--------------------------------------------------+
       |                Application Layer                 |
       |             (Use Cases, Contracts)               |
       +------------------------+-------------------------+
                                |
                                v
       +--------------------------------------------------+
       |                  Domain Layer                    |
       |   (Entities, Value Objects, Domain Exceptions)   |
       +------------------------+-------------------------+
                                ^
                                |
       +--------------------------------------------------+
       |                   Data Layer                     |
       |  (Repositories, Models, Data Sources, Mappers)   |
       +--------------------------------------------------+