<div align="center">

<br/>

```
 ███████╗██╗    ██╗██╗███████╗████████╗██████╗  ██████╗ ███████╗
 ██╔════╝██║    ██║██║██╔════╝╚══██╔══╝██╔══██╗██╔═══██╗██╔════╝
 ███████╗██║ █╗ ██║██║█████╗     ██║   ██████╔╝██║   ██║███████╗
 ╚════██║██║███╗██║██║██╔══╝     ██║   ██╔═══╝ ██║   ██║╚════██║
 ███████║╚███╔███╔╝██║██║        ██║   ██║     ╚██████╔╝███████║
 ╚══════╝ ╚══╝╚══╝ ╚═╝╚═╝        ╚═╝   ╚═╝      ╚═════╝ ╚══════╝
```

### ⚡ Point of Sale Management System

<br/>

[![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.java.com)
[![JSP](https://img.shields.io/badge/JSP%20%2F%20Servlets-007396?style=for-the-badge&logo=java&logoColor=white)](https://jakarta.ee)
[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com)
[![Tomcat](https://img.shields.io/badge/Apache%20Tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)](https://tomcat.apache.org)
[![JDBC](https://img.shields.io/badge/JDBC-3C3C3C?style=for-the-badge&logo=java&logoColor=white)](https://docs.oracle.com/javase/tutorial/jdbc/)

<br/>

> **SwiftPOS** is a fast, role-based web Point-of-Sale system built for small and medium-sized businesses — covering sales, inventory, users, and reporting in one clean interface.

<br/>

---

</div>

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Database Setup](#database-setup)
  - [Running the App](#running-the-app)
- [User Roles](#-user-roles)
- [Pages & Modules](#-pages--modules)
- [CSS Architecture](#-css-architecture)
- [Team](#-team)

---

## 🧭 Overview

SwiftPOS is a **Java EE web application** that provides a complete point-of-sale experience — from cashier checkout to admin-level reporting — all running through a browser with no desktop install required.

Built on a clean **MVC architecture** with JSP views, Servlet controllers, DAO-pattern data access, and a MySQL backend, SwiftPOS is designed to be maintainable, extensible, and straightforward to deploy on any machine running XAMPP or a Tomcat server.

---

## ✨ Features

| Feature | Description |
|--------|-------------|
| 🔐 **Role-Based Access** | Separate views and permissions for Admins and Cashiers |
| 🛒 **Point-of-Sale Interface** | Cart-based sales flow with quantity selection and payment handling |
| 📦 **Product & Category Management** | Full CRUD for products and categories with image support |
| 👥 **User Management** | Admin-only user creation and management |
| 🧾 **Receipt Generation** | Printable, styled receipts per transaction |
| 📊 **Sales Reports** | Filter and visualize sales data by date and cashier |
| 🎨 **Modular CSS** | Scoped stylesheets per page, built on a shared global base |
| ⚠️ **Custom Error Pages** | Friendly, redirect-equipped error handling |

---

## 🛠 Tech Stack

| Layer | Technology |
|-------|------------|
| **Backend** | Java, Jakarta Servlets |
| **View** | JSP (JavaServer Pages) |
| **Data Access** | JDBC with DAO pattern |
| **Database** | MySQL 8+ |
| **Server** | Apache Tomcat |
| **Frontend** | HTML5, CSS3, JavaScript |
| **DB Driver** | `mysql-connector-j-9.2.0.jar` |
| **Build Tool** | Apache Ant (`build.xml`) |
| **Dev Environment** | NetBeans IDE + XAMPP |

---

## 📁 Project Structure

```
SwiftPOS/
│
├── 📂 database/
│   ├── pos_schema.sql          # Table definitions
│   ├── pos_sample_data.sql     # Seed data for testing
│   └── ER_Diagram.png          # Entity-Relationship diagram
│
├── 📂 lib/
│   └── mysql-connector-j-9.2.0.jar
│
├── 📂 src/java/
│   ├── 📂 controller/          # Servlets (request handlers)
│   │   ├── LoginServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── UserServlet.java
│   │   ├── ProductServlet.java
│   │   ├── CategoryServlet.java
│   │   ├── SalesServlet.java
│   │   ├── ReceiptServlet.java
│   │   └── ReportServlet.java
│   │
│   ├── 📂 dao/                 # Data Access Objects
│   │   ├── UserDAO.java
│   │   ├── ProductDAO.java
│   │   ├── CategoryDAO.java
│   │   ├── SalesDAO.java
│   │   └── ReportDAO.java
│   │
│   ├── 📂 model/               # Java Beans / POJOs
│   │   ├── User.java
│   │   ├── Product.java
│   │   ├── Category.java
│   │   ├── Sale.java
│   │   ├── SaleItem.java
│   │   └── Receipt.java
│   │
│   └── 📂 util/
│       └── DBConnection.java   # Singleton DB connection utility
│
└── 📂 web/
    ├── 📂 jsp/                 # All JSP view pages
    │   ├── login.jsp
    │   ├── admin_dashboard.jsp
    │   ├── users.jsp
    │   ├── products.jsp
    │   ├── categories.jsp
    │   ├── sales.jsp
    │   ├── receipt.jsp
    │   ├── reports.jsp
    │   ├── about.jsp
    │   ├── help.jsp
    │   └── error.jsp
    │
    ├── 📂 css/                 # Modular stylesheets
    │   ├── style.css           # Global base styles
    │   ├── login.css
    │   ├── dashboard.css
    │   ├── form.css
    │   ├── receipt.css
    │   ├── report.css
    │   ├── layout.css
    │   ├── about-help.css
    │   ├── error.css
    │   └── users.css
    │
    ├── 📂 js/
    │   ├── form-validation.js
    │   ├── loader.js
    │   └── report-charts.js
    │
    ├── 📂 images/              # Icons, logos, illustrations
    │
    └── 📂 WEB-INF/
        └── web.xml             # Servlet mappings & config
```

---

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- ✅ [XAMPP](https://www.apachefriends.org/) (Apache + MySQL)
- ✅ [Apache Tomcat 10+](https://tomcat.apache.org/)
- ✅ [NetBeans IDE](https://netbeans.apache.org/) *(recommended)* or any Java IDE
- ✅ JDK 11 or higher

---

### Database Setup

**1. Start XAMPP**

Open XAMPP Control Panel and start both **Apache** and **MySQL**.

**2. Open phpMyAdmin**

Click **Admin** next to MySQL to open phpMyAdmin in your browser.

**3. Create the database**

```sql
CREATE DATABASE swiftpos_db CHARACTER SET utf8 COLLATE utf8_general_ci;
```

**4. Import the schema**

- Select `swiftpos_db` in the left panel
- Go to **Import** tab
- Upload and run `database/pos_schema.sql`

**5. *(Optional)* Load sample data**

```
Import → database/pos_sample_data.sql
```

---

### Running the App

**1. Clone the repository**

```bash
git clone https://github.com/your-username/SwiftPOS.git
```

**2. Open in NetBeans**

- `File → Open Project` → select the `SwiftPOS` folder


**3. Build & Deploy**

- Right-click project → **Clean and Build**
- Right-click project → **Run** (deploys to Tomcat automatically)

**4. Open in browser**

```
http://localhost:8080/SwiftPOS/
```

---

## 👤 User Roles

| Role | Access |
|------|--------|
| **Admin** | Full access — users, products, categories, sales, reports |
| **Cashier** | Sales module only — process transactions, print receipts |

> Default admin credentials can be found in `pos_sample_data.sql`

---

## 📄 Pages & Modules

| JSP Page | Description | CSS Used |
|----------|-------------|----------|
| `login.jsp` | Animated login screen | `style.css` + `login.css` |
| `admin_dashboard.jsp` | Stats widgets, quick actions | `style.css` + `dashboard.css` |
| `users.jsp` | User management with tables | `style.css` + `users.css` |
| `products.jsp` | Inventory management & forms | `style.css` + `form.css` |
| `categories.jsp` | Category organization | `style.css` + `form.css` |
| `sales.jsp` | POS cart interface | `style.css` + `form.css` |
| `receipt.jsp` | Printable transaction receipt | `style.css` + `receipt.css` |
| `reports.jsp` | Charts, filters, data table | `style.css` + `report.css` |
| `about.jsp` | Project & team info | `style.css` + `about-help.css` |
| `help.jsp` | User guide & FAQs | `style.css` + `about-help.css` |
| `error.jsp` | Friendly error with redirect | `style.css` + `error.css` |

---

## 🎨 CSS Architecture

SwiftPOS uses a **modular, scoped stylesheet system**:

```
style.css  ← Global base (typography, variables, shared components)
    │
    ├── login.css       ← Auth page only
    ├── dashboard.css   ← Admin dashboard only
    ├── form.css        ← Shared across product/category/sales forms
    ├── receipt.css     ← Print-optimized receipt layout
    ├── report.css      ← Charts and data tables
    ├── users.css       ← User management tables
    └── about-help.css  ← Info and documentation pages
```

Every page loads `style.css` as the foundation, then imports its scoped stylesheet to add or override styles only where needed. This avoids duplication and keeps the codebase clean as the project grows.

---

## 🛠 Project Interfaces
<img width="1842" height="895" alt="login" src="https://github.com/user-attachments/assets/638c8934-a074-47af-97ff-2a5556f8ff24" />

<img width="1876" height="890" alt="dashboard" src="https://github.com/user-attachments/assets/5de2f110-ddf0-44b2-bad4-1c12f7c091ef" />
<img width="1858" height="881" alt="users" src="https://github.com/user-attachments/assets/dde18881-662a-48a9-b8d7-8ae5f6d68b2e" />

<img width="1886" height="838" alt="products" src="https://github.com/user-attachments/assets/b4db2629-7929-40f8-ba1f-90e46c1206a3" />

<img width="1876" height="876" alt="categories" src="https://github.com/user-attachments/assets/44e2b003-5b75-4288-b9a9-73329a2e4f5b" />

<img width="1903" height="887" alt="sales" src="https://github.com/user-attachments/assets/0cecb7c1-843a-454f-82dc-ffa2fd79b7da" />




---


## 👨‍💻 Team

| Name | Role |
|------|------|
| **Gaya** | Full Stack Developer, Project Lead |

> 🎓 Faculty of Computing  
> 📅 Version 1.0 · 2025  
> 📧 Support: `support@swiftpos.com`

---

<div align="center">

<br/>

**SwiftPOS** — Built with ☕ Java and a lot of `System.out.println()` debugging.

<br/>

*© 2025 SwiftPOS*

</div>
