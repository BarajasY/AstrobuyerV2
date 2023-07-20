use sqlx_postgres::PgPool;

pub async fn get_db_pool() -> PgPool {
    let test =dotenvy::var("CONN_STRING").expect("Error loading variable");

    PgPool::connect(test.as_str()).await.expect("Error connecting to database.")

}
