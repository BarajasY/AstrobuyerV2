# AstrobuyerV2
Full-Stack ecommerce website/mobile app.

# About
Astrobuyer is a simulated e-commerce store to buy planets. Since it's a simulated site and only designed for learning purposes, It doesn't actually has any integration with Stripe or other payments service. Below you can read more about the tech stack used to build this application. This project is a "remake" of my old Astrobuyer website (which you can find in my github)

# Backend
This project uses the almighty Rust language as It's backend server. Using the Axum and SQLX crate in order to make http operations and database operations.

# Frontend
The UI library used for this project is none other than Solid.js purely because of It's raw performance. At first i didn't really enjoy coding in Solid.js, but after comparing the speed it gives with that of Next.js/React.js I started to value Solid more and more.

# Mobile
This is my first mobile project, and as such there was quite a lot of learning in this section. The framework and language of choice for the mobile version of this application is Dart with Flutter. I must say the excellent tools that this technology offers is really impressive, at some point I was making the entire ui of a screen without realizing the amount of code I've already written.

# Database
This project uses a standard relational PSQL database. Might change the database to an AWS instance of RDS with PSQL.
