# 1. What is PostgreSQL?

PostgreSQL হল একটি advanced general purpose object-relational database management system এবং এটি হল open source যা কিনা enterprise-level performance এবং reliability দিতে পারবে। এটি একাধারে SQL (relational) এবং JSON (non-relational) উভয় Query তে কাজ করবে।  

# 2. What is the purpose of a database schema in PostgreSQL?

Database Schema  হল এমন একটি পন্থা যার মাধ্যমে আমরা database কে organise করতে পারি এবং database objects কে namespace করতে পারি (tables, views, functions)

এটা আমাদেরকে এই object গুলোকে logical grouping করতে দিবে এবং এই object গুলোকে manage করতে দিবে। যা আমাদেরকে name collision এবং developers দের মধ্যে collaboration বাড়াবে। 

 ## 1. Organization and Maintainability

 schemas আমাদেরকে related database objects গুলো কে logical units এ গ্রুপ করতে দিবে যা আমাদের কে complex data structure manage এবং বুঝতে সাহায্য করবে।

 ## 2. Namespace

 Schema namespace হিসেবে কাজ করবে যা কিনা আমাদের কে আলাদা schema তে  objects রাখতে দিবে একই নামে। 

 ## 3. Security and Access Control

 আমরা একটি specific users অথবা roles কে একটি নির্দিষ্ট schema তে access দিতে পারি যা আমাদের ডাটার উপরে আরো বেশি access দিতে পারবে।

 ## 4. Collaboration

 স্কিমা আলাদা ডেভেলপের দের কে একই ডাটাবেসে কাজ করার সুযোগ করে দিবে কোন conflict ছাড়াই। 

# 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

primary keys আমাদের কে ensure করে যেন database table এর আলাদা record গুলো একদম unique থাকে। যা কিনা data integrity maintain করে এবং duplication থেকে আমাদের বাঁচায়। 

Foreign keys টেবিল গুলোর মধ্যে একটি সম্পর্ক তৈরি করে যা কিনা আমাদের কে Data কে structured organization করতে সাহায্য করে এবং database এ referential integrity প্রদান করে। 

# 4. Explain the purpose of the WHERE clause in a SELECT statement.

WHERE clause যা কিনা SELECT statement এ ব্যবহার করা হয় যা দিয়ে table এর row কে filter করা যায় এবং আমাদের কে একটি নির্দিষ্ট data কন্ডিশন অনুসারে তুলে আনতে সাহায্য করে। অর্থাৎ আমাদের field value যেটা আছে সেটা যদি আমাদের দরকার অনুযায়ী ঠিক থাকে তাহলে query results এ সেটা দেখাবে। 

## Filtering Data

WHERE clause একটা filter হয়ে কাজ করে এবং ওই ডাটা গুলাই আমাদেরকে দেখাবে যেটা আসলে চাই।

## Conditions

Conditions গুলো একদম simple comparisons হতে পারে যেমন =, >, < অথবা logical operators দিয়ে আরো জটিল এক্সপ্রেসন চালাতে পারি যেমন AND, OR

## Example

SELECT * FROM Customers WHERE city = 'New York' 

সকল rows গুলা নিয়ে আসবে যেখানে city = 'New York'

# 5. How can you modify data using UPDATE statements?

একটি উদাহরণ দেখাযাক

students নামে tables এ যদি দেখি 

id	name	age
1	John	14
2	Sarah	15

যদি আমি Sarah এর age পরিবর্তন করতে চাই

UPDATE students
SET age = 16
WHERE name = 'Sarah';

Result:
id	name	age
1	John	14
2	Sarah	16