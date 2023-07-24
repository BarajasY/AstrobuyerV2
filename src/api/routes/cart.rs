use axum::{extract::{State, Path}, Json};
use http::StatusCode;
use sqlx::Row;
use sqlx_postgres::PgPool;
use serde::{Deserialize, Serialize};

use super::astros::Astros;

#[derive(Serialize, Deserialize)]
pub struct AddToCart {
    user_id: i32,
    astro_id: i32
}


pub async fn add_to_cart(State(db_pool): State<PgPool>, Json(payload): Json<AddToCart>) -> StatusCode {
    let query = "INSERT INTO cart (user_id, astro_id) VALUES ($1, $2)";

    sqlx::query(query)
        .bind(payload.user_id)
        .bind(payload.astro_id)
        .execute(&db_pool)
        .await
        .expect("Error adding to cart");

    StatusCode::OK
}

pub async fn delete_from_cart(State(db_pool): State<PgPool>, Json(payload): Json<AddToCart>) -> StatusCode {
    let query = "DELETE FROM cart WHERE user_id = $1 AND astro_id = $2";

    sqlx::query(query)
        .bind(payload.user_id)
        .bind(payload.astro_id)
        .execute(&db_pool)
        .await
        .expect("Error deleting from cart");

    StatusCode::OK
}

pub async fn get_cart(State(db_pool): State<PgPool>, Path(user_id): Path<i32>) -> (StatusCode, Json<Vec<Astros>>) {
    let query = "SELECT * FROM cart WHERE user_id = $1";

    let rows = sqlx::query(query)
        .bind(user_id)
        .fetch_all(&db_pool)
        .await
        .expect("Error retrieving cart from database.");

    //Queries lookup cart table and then with the results of that table queries the Astros table.
    //Would query the astros table directly from here but i would need an async closure which are unstable.
    let cart: Vec<AddToCart> = rows.iter().map(|r| {
        AddToCart {
            user_id: r.get("user_id"),
            astro_id: r.get("astro_id")
        }
    }).collect();

    let mut astros:Vec<Astros> = Vec::new();

    for item in cart {
        let row = sqlx::query("SELECT * from astros WHERE id = $1")
            .bind(item.astro_id)
            .fetch_one(&db_pool)
            .await
            .expect("Error executing second query.");

        let result:Astros = Astros {
            id: row.get("id"),
            name: row.get("name"),
            price: row.get("price"),
            category: row.get("category"),
            temperature: row.get("temperature"),
            image: row.get("image")
        };

        astros.push(result);
    }

    (StatusCode::OK, Json(astros))

}