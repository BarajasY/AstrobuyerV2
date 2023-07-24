use axum::{routing::{get, post},Router};

use crate::api::{routes::{astros::{make_astro, delete_astro, get_one_astro}, users::{create_user, delete_user, get_user}, cart::{add_to_cart, delete_from_cart, get_cart}}, cors::make_cors};

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
    .route("/astros/:id", get(get_one_astro))
    .route("/user/create", post(create_user))
    .route("/user/delete", post(delete_user))
    .route("/user/login", post(get_user))
    .route("/cart/add", post(add_to_cart))
    .route("/cart/delete", post(delete_from_cart))
    .route("/cart/get/:user_id", post(get_cart))
    .layer(make_cors())
    .with_state(db_pool)
}
