use api::router::get_router;

mod api;

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();
    dotenvy::dotenv().expect("Error loading dotenv variables");

    println!("Server is running!");
    axum::Server::bind(&"0.0.0.0:8000".parse().unwrap())
        .serve(get_router().await.into_make_service())
        .await
        .unwrap();
}
