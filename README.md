# E-Commerce Business Intelligence & Revenue Growth Analysis (SQL)

## Project Overview
An end-to-end data analysis project simulating real-world commercial challenges of an e-commerce platform. Using MySQL, this project analyzes customer acquisition cohorts, month-over-month revenue velocity, basket sizes, and product catalog performance to deliver actionable business strategies.

## Data Model & Schema
The relational database consists of 4 core tables:
- **Customers**: Demographics and geographic locations.
- **Products**: SKU names, pricing, and product categories.
- **Orders**: Transaction records, dates, and order values.
- **OrderDetails**: Line-item granularity, unit pricing, and quantities sold.

---

## Key Business Insights & Strategic Recommendations

### 1. Revenue & Average Order Value (AOV)
- **Insight:** Monthly revenue shows strong fluctuations due to seasonal demand, but the Average Order Value (AOV) remains flat across quarters. This shows growth was driven solely by order volume rather than basket expansion.
- **Recommendation:** Implement minimum order value (MOV) thresholds for free delivery and bundle complementary items at checkout to lift AOV.

### 2. Customer Retention & Repeat Purchase
- **Insight:** A significant portion of acquired users are "one-time buyers" who do not return after their first purchase.
- **Recommendation:** Deploy automated email/SMS retention workflows around Day 14 and Day 30 post-first order, offering targeted category discounts.

### 3. Inventory & Catalog Penetration
- **Insight:** 80% of transactions are concentrated in a few high-velocity items, while multiple SKUs fail to reach even 40% of the customer base, tying up working capital.
- **Recommendation:** Run clearance/bundle campaigns on low-penetration SKUs to reduce carrying costs and maintain safety stock on the top 5 high-frequency SKUs.

---

## Technical Concepts Used
- **CTEs (Common Table Expressions)** for clean, modular data pipelines.
- **Window Functions (`LAG`, `OVER`)** for MoM growth rates and running distribution calculations.
- **Multi-Table Joins & Dynamic Subqueries** for catalog penetration analysis.
