use axum::{routing::{get, post},Router};

use crate::api::routes::{astros::{make_astro, delete_astro}, users::{create_user, delete_user, get_user}};

use super::{db::get_db_pool, routes::astros::{get_astros, root}};


pub async fn get_router() -> Router {
    let db_pool = get_db_pool().await;
    println!("Connected to database");

    sqlx::migrate!("./migrations").run(&db_pool).await.expect("Error running migrations");

    println!("Migrations done correctly.");

    Router::new()
    .route("/", get(root))
    .route("/astros", get(get_astros).post(make_astro))
    .route("/astros/delete", post(delete_astro))
    .route("/user/create", post(create_user))
    .route("/user/delete", post(delete_user))
    .route("/user/login", post(get_user))
    .with_state(db_pool)
}
