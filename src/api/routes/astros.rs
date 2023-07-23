use axum::{extract::{State, Path}, Json, http::StatusCode};
use serde::{Deserialize, Serialize};
use sqlx::Row;
use sqlx_postgres::PgPool;

#[derive(Deserialize, Serialize)]
pub struct Astros {
    id: Option<i32>,
    name: String,
    price: i32,
    category: String,
    temperature: i32,
    image: String
}

#[derive(Deserialize, Serialize)]
pub struct DeleteAstro {
    id: i32
}

pub async fn root()-> &'static str {
    "Homepage for Astrobuyer site!"
}

pub async fn get_astros(State(db_pool): State<PgPool>) -> (StatusCode, Json<Vec<Astros>>) {

    let rows = sqlx::query("SELECT * FROM astros").fetch_all(&db_pool).await.expect("Error executing query");

    let astros: Vec<Astros> =rows.iter().map(|a| {
        Astros {
            id: a.get("id"),
            name: a.get("name"),
            price: a.get("price"),
            category: a.get("category"),
            temperature: a.get("temperature"),
            image: a.get("image")
        }
    }).collect();

    (StatusCode::OK, Json(astros))

}

pub async fn make_astro(State(db_pool): State<PgPool>, Json(payload): Json<Astros>) -> StatusCode {
    let query = "INSERT INTO astros (name, price, category, temperature, image) VALUES ($1, $2, $3, $4, $5)";

    sqlx::query(query)
        .bind(&payload.name)
        .bind(payload.price)
        .bind(&payload.category)
        .bind(payload.temperature)
        .bind(&payload.image)
        .execute(&db_pool).await.expect("Error running make_astro query");

    StatusCode::OK
}

pub async fn delete_astro(State(db_pool): State<PgPool>, Json(payload): Json<DeleteAstro>) -> StatusCode {
    let query = "DELETE FROM astros WHERE id = $1";

    sqlx::query(query)
    .bind(payload.id)
    .execute(&db_pool)
    .await.expect("Error deleting astro.");

    StatusCode::OK
}

pub async fn get_one_astro(State(db_pool):State<PgPool>, Path(id): Path<i32>) -> (StatusCode, Json<Astros>) {
    let query = "SELECT * FROM astros WHERE id = $1";

    let row = sqlx::query(query)
        .bind(id)
        .fetch_one(&db_pool)
        .await
        .expect("Error querying 1 by id.");

    let astro:Astros = Astros {
        id: row.get("id"),
        name: row.get("name"),
        price: row.get("price"),
        category: row.get("category"),
        temperature: row.get("temperature"),
        image: row.get("image")
    };

    (StatusCode::OK, Json(astro))
}
