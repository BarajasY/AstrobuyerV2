use axum::{routing::get,Router};

use super::{db::get_db_pool, planets::astros::root};


pub async fn get_router() -> Router {
    let db_pool = get_db_pool().await;
    println!("Connected to database");

    Router::new()
    .route("/", get(root))
    .with_state(db_pool)
}
