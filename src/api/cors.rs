use http::{Method, header::CONTENT_TYPE};
use tower::{ServiceBuilder, layer::util::{Stack, Identity}};
use tower_http::cors::{CorsLayer, Any};

pub fn make_cors() -> ServiceBuilder<Stack<CorsLayer, Identity>> {
    let cors = CorsLayer::new()
    .allow_methods([Method::GET, Method::POST])
    .allow_origin(Any)
    .allow_headers([CONTENT_TYPE]);

    ServiceBuilder::new()
        .layer(cors)
}
