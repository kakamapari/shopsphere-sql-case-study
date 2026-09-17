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


## 🤖 AI-Assisted Development

AI was used as a development assistant throughout the project to make the workflow more efficient and easier to understand.

AI helped with:

- Planning parts of the database structure
- Generating and organizing synthetic data
- Explaining SQL errors and debugging queries
- Suggesting analysis ideas
- Structuring the Power BI dashboard
- Explaining Python and machine learning concepts
- Reviewing K-Means clustering steps and results
- Organizing the GitHub documentation

All SQL queries, Power BI visuals, Python code, model execution, validation, and analysis were run and reviewed manually as part of the project.

## 🤖 Machine Learning – Customer Segmentation

To extend the ShopSphere analytics project beyond SQL and Power BI, I built a customer segmentation model using **K-Means clustering** in Python.

### ML Objective

The goal was to group customers based on purchasing behavior using RFM-style features:

- **Recency** – days since the customer's most recent order
- **Frequency** – number of orders placed
- **Monetary** – total customer spend

The final ML dataset contained **989 customers** with valid transaction history.

### Data Preparation

Before clustering, I:

- Checked missing values and duplicates
- Reviewed feature distributions and outliers
- Applied `log1p()` transformation to reduce skew
- Standardized features using `StandardScaler`

### Choosing the Number of Clusters

I evaluated different cluster counts using:

- Elbow Method
- Silhouette Score
- Business interpretability

Although **K = 2** produced the highest silhouette score, **K = 4** was selected because it produced more useful and interpretable customer groups.

### Final Customer Segments

| Segment | Customers | Avg Recency | Avg Orders | Avg Spend |
| --- | ---: | ---: | ---: | ---: |
| Recent Customers | 176 | 17.66 days | 4.68 | ₹38,905 |
| Cooling Customers | 373 | 206.29 days | 3.55 | ₹31,062 |
| High-Value Loyal Customers | 301 | 104.33 days | 6.49 | ₹63,488 |
| Inactive Low-Value Customers | 139 | 307.46 days | 1.64 | ₹10,362 |

### Power BI ML Integration

The final customer segments were exported from Python and imported back into Power BI.

A new **Customer Segmentation** page was added with:

- Customers by Segment
- Average Spend by Segment
- Average Orders by Segment
- Average Recency by Segment
- Frequency vs Spend scatter plot
- Customer Segment slicer

![Customer Segmentation](powerbi/Customer_Segmentation.png)

### ML Tools Used

- Python
- Pandas
- NumPy
- Matplotlib
- Scikit-learn
- K-Means Clustering
- StandardScaler
- Power BI

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
