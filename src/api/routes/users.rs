use axum::{extract::State, http::StatusCode, Json};
use serde::{Deserialize, Serialize};
use sqlx::Row;
use sqlx_postgres::PgPool;

#[derive(Serialize, Deserialize)]
pub struct User {
    id: Option<i32>,
    username: String,
    pass: String,
    email: String,
}

#[derive(Serialize, Deserialize)]
pub struct DeleteUser {
    id: i32,
}

#[derive(Serialize, Deserialize)]
pub struct UserToClient {
    username: String,
    email: String,
}

#[derive(Serialize, Deserialize)]
pub struct Login {
    email: String,
    pass: String,
}

pub async fn create_user(State(db_pool): State<PgPool>, Json(payload): Json<User>) -> StatusCode {
    let query = "INSERT INTO users (username, pass, email) VALUES ($1, $2, $3)";

    sqlx::query(query)
        .bind(&payload.username)
        .bind(&payload.email)
        .bind(&payload.pass)
        .execute(&db_pool)
        .await
        .expect("Error creating user");

    StatusCode::OK
}

pub async fn delete_user(
    State(db_pool): State<PgPool>,
    Json(payload): Json<DeleteUser>,
) -> StatusCode {
    let query = "DELETE FROM users WHERE id = $1";

    sqlx::query(query)
        .bind(payload.id)
        .execute(&db_pool)
        .await
        .expect("Error deleting user");

    StatusCode::OK
}

pub async fn get_user(
    State(db_pool): State<PgPool>,
    Json(payload): Json<Login>,
) -> (StatusCode, Json<UserToClient>) {

    let query = "SELECT FROM users WHERE email = $1 AND pass = $2";

    let row = sqlx::query(query)
        .bind(&payload.email)
        .bind(&payload.pass)
        .fetch_one(&db_pool)
        .await
        .expect("Error logging user in.");

    let user: UserToClient = UserToClient {
        username: row.get("username"),
        email: row.get("email")
    };

    (StatusCode::OK, Json(user))
}
