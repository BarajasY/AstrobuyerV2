CREATE TABLE cart (
    user_id integer NOT NULL,
    astro_id integer NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (astro_id) REFERENCES astros(id)
);
