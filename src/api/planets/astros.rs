use axum::{extract::State, Json, http::StatusCode};
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

pub async fn root()-> &'static str {
    "Hola"
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
        .bind(&payload.price)
        .bind(&payload.category)
        .bind(&payload.temperature)
        .bind(&payload.image)
        .execute(&db_pool).await.expect("Error running make_astro query");

    StatusCode::OK
}
