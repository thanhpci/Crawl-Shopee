# Shopee.vn Web Scraping Tool

## Introduction
This tool was developed to collect data from the [shopee.vn](https://shopee.vn/) website, specializing in online products. Detailed information from major product categories is collected and transformed into CSV format.

## Product Data Features
Each collected product includes the following information:
- **Crawl Time:** The moment the data was collected.
- **Product Type:** Product classification.
- **Product Name:** The name of the product.
- **Link:** The URL to the product page.
- **Average Rating:** Average user rating.
- **Product Price:** The selling price of the product.
- **Supply Location:** The location where the product is supplied.
- **Total Revenue:** Total revenue at the time of crawling (calculated based on the highest price if the product has multiple price levels).

## Statistics
- **Amount of Data Collected:** 4665 products (as of the time of statistics).
- **Crawl Rate:** About 8 products/minute (from 02:30:28 on 30/01/2024 to 09:14:28 on 30/01/2024).

## Usage Instructions
1. **Open Edge Browser:** Log into [shopee.vn](https://shopee.vn/).
2. **Install Autohotkey:** Download and install [Autohotkey v2](https://www.autohotkey.com/).
3. **Download the Project:** Download the project folder from Git to your computer.
4. **Disable Edge Extensions:** Turn off all extensions in Edge to not interfere with the crawling process.
5. **Close All Edge Windows:** Close all previously opened Edge windows.
6. **Run Main.ahk File:** Navigate to `\CrawlShopee\main.ahk` in the project folder and run the file.
7. **Do Not Interact During Crawling:** Avoid interacting with the Edge window while data is being collected.
8. **Exit Application:** Use the `Ctrl+Shift+F3` key combination to exit the application.
