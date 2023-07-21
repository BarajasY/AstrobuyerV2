use axum::http::Method;
use tower::{ServiceBuilder, layer::util::{Stack, Identity}};
use tower_http::cors::{CorsLayer, Any};

pub fn make_cors() -> ServiceBuilder<Stack<CorsLayer, Identity>> {
    let cors = CorsLayer::new()
    .allow_methods([Method::GET, Method::POST])
    .allow_origin(Any);

    ServiceBuilder::new()
        .layer(cors)
}
