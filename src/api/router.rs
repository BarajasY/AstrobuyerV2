use axum::{routing::get,Router};

use crate::api::planets::astros::make_astro;

use super::{db::get_db_pool, planets::astros::{get_astros, root}};


pub async fn get_router() -> Router {
    let db_pool = get_db_pool().await;
    println!("Connected to database");

    sqlx::migrate!("./migrations").run(&db_pool).await.expect("Error running migrations");

    println!("Migrations done correctly.");

    Router::new()
    .route("/", get(root))
    .route("/astros", get(get_astros).post(make_astro))
    .with_state(db_pool)
}
