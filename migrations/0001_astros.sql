CREATE TABLE astros (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price INTEGER NOT NULL,
    category VARCHAR(30),
    temperature INTEGER,
    image TEXT
);
