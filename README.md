# 🛒 ShopSphere E-Commerce SQL Case Study

## 🛠️ Tools Used

- MariaDB
- SQL
- Power BI
- Power Query
- DAX
- GitHub

## 📌 Project Overview

ShopSphere is an AI-assisted e-commerce database and SQL analytics case study built using MariaDB.

Unlike projects that begin with a ready-made dataset, this project involved designing a relational database structure, generating thousands of synthetic records, validating and cleaning the data, and performing business analysis using SQL.

The database contains more than **28,000 business records** across customers, orders, order items, payments, reviews, products, and categories, supported by a **10,000-row helper table**.

The project demonstrates both traditional SQL/data-analysis skills and the practical use of AI as a development assistant for database design, synthetic data generation, debugging, and analytical workflow development.


## 🤖 AI-Assisted Database Design & Data Generation

A key part of this project was building a complete relational e-commerce database from scratch rather than working with a ready-made Kaggle dataset.

I designed the **ShopSphere database structure** to simulate a real-world e-commerce environment, including relationships between:

- Customers
- Orders
- Order Items
- Products
- Categories
- Payments
- Reviews

To efficiently create a dataset large enough for meaningful SQL analysis, I used **AI-assisted development** to help design and generate synthetic data.

The final database contained:

| Table | Records |
|---|---:|
| Customers | 1,000 |
| Orders | 5,000 |
| Order Items | 10,000 |
| Payments | 5,000 |
| Reviews | 2,000 |
| Products | 20 |
| Categories | 7 |
| Numbers Helper Table | 10,000 |

Instead of manually inserting thousands of records, a helper `numbers` table and SQL-based generation techniques were used to create data at scale.

AI was used as a development assistant for:

- Planning the relational database structure
- Generating synthetic e-commerce data
- Developing and improving SQL queries
- Debugging incorrect joins and calculations
- Organizing the analysis workflow
- Reviewing data-quality issues

The generated data was not simply accepted as correct. I manually executed and tested the SQL queries in **MariaDB**, validated table relationships and row counts, investigated unexpected results, corrected SQL errors, and analyzed the final outputs.

This project demonstrates how **SQL knowledge and AI-assisted workflows can be combined to efficiently design, generate, validate, and analyze a relational e-commerce database at scale.**

## 📊 Power BI Dashboard

To extend the SQL analysis, I built an interactive **4-page Power BI dashboard** connected to the ShopSphere MariaDB database.

The dashboard transforms the SQL case study into an interactive business intelligence report with KPI tracking, product analysis, customer analysis, order trends, payment performance, and geographic insights.

### Dashboard Pages

#### 1. Executive Overview
- Total Revenue
- Total Profit
- Total Orders
- Average Order Value
- Profit Margin
- Monthly Revenue Trend
- Revenue & Profit by Category
- Top Products by Revenue
- Order Status Distribution

![Executive Overview](powerbi/Executive_Overview.png)

#### 2. Product & Category Analysis
- Top Products by Profit
- Top Products by Quantity Sold
- Product Profit Margin
- Average Product Rating
- Category Profit Margin
- Interactive Year, Category, and Product filters

![Product & Category Analysis](powerbi/Product_Category_Analysis.png)

#### 3. Customer Analysis
- Top Customers by Total Spend
- Top Customers by Average Order Value
- Top Customers by Order Count
- Customer Distribution by Gender
- Customers by State

![Customer Analysis](powerbi/Customer_Analysis.png)

#### 4. Orders & Payments Analysis
- Payment Amount by Method
- Payment Status Distribution
- Orders by Shipping State
- Top Shipping Cities
- Order Status vs Payment Status
- Interactive Year, Shipping State, and Payment Method filters

![Orders & Payments Analysis](powerbi/Orders_Payments_Analysis.png)

### Power BI Features Used

- DAX Measures
- Data Modeling & Relationships
- Power Query
- Date Table
- KPI Cards
- Interactive Slicers
- Synced Slicers
- Page Navigation
- Top N Filtering
- Drill-down capable visuals
- Custom Dashboard Theme & Background Design

### Key DAX Measures

- Total Revenue
- Total Profit
- Total Orders
- Average Order Value
- Customer AOV
- Profit Margin %
- Analyzed Orders

### Dashboard File

The Power BI `.pbix` file is available in the [`powerbi`](powerbi/) folder.
