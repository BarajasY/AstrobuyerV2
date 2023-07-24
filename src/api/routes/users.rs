use axum::{extract::State, http::StatusCode, Json};
use serde::{Deserialize, Serialize};
use sqlx::Row;
use sqlx_postgres::PgPool;

#[derive(Serialize, Deserialize)]
pub struct User {
    id: Option<i32>,
    username: String,
    email: String,
    pass: String,
}

#[derive(Serialize, Deserialize)]
pub struct DeleteUser {
    id: i32,
}

#[derive(Serialize, Deserialize)]
pub struct UserToClient {
    id: i32,
    username: String,
    email: String,
}

#[derive(Serialize, Deserialize)]
pub struct Login {
    email: String,
    pass: String,
}

pub async fn create_user(State(db_pool): State<PgPool>, Json(payload): Json<User>) -> StatusCode {
    let query = "INSERT INTO users (username, email, pass) VALUES ($1, $2, $3)";

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
    let query = "SELECT * FROM users WHERE email = $1 AND pass = $2";
    //Initialized empty UserToClient variable.
    let placeholder: UserToClient = UserToClient {
        id: 0,
        username: String::from("wasd"),
        email: String::from("wasd"),
    };

    //Execute OPTIONAL query.
    //Used optional query in order to not print an error every single time a user mistakes their account.
    let row = sqlx::query(query)
        .bind(payload.email)
        .bind(payload.pass)
        .fetch_optional(&db_pool)
        .await
        //Up until this point Row would be of type Result<Option<PgRow>>.
        //.expect will get rid of the Result<> wrapper.
        .expect("Error executing query");

    //Optional handling.
    match row {
        None => {
            //User inserted incorrect information. Thereby query returned none.
            //Returns empty user variable formed at the start.
            (StatusCode::CONFLICT, Json(placeholder))
        }
        Some(row) => {
            //User inserted correct information of email and password.
            //Thereby query returned a row.
            let user:UserToClient = UserToClient {
                id: row.get("id"),
                email: row.get("email"),
                username: row.get("username")
            };

            (StatusCode::OK, Json(user))
        }
    }
}
