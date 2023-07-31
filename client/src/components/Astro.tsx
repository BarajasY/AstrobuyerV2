import { Component, Match, Switch, createSignal } from "solid-js";
import style from "../styles/Astro.module.css";
import { useQuery } from "../utils/utils";
import { useParams } from "@solidjs/router";
import { BsCart } from "solid-icons/bs";
import { User } from "../utils/sharedSignals";
import { Motion, Presence} from "@motionone/solid";

const Astro: Component = () => {
  const params = useParams();
  const query = useQuery(
    "GetOneAstro",
    `http://localhost:8000/astros/${params.id}`
  );
  const [Success, setSuccess] = createSignal(false);

  const AddToCart = async () => {
    const post = await fetch("http://localhost:8000/cart/add", {
      headers: {
        "Content-type": "application/json",
      },
      method: "POST",
      body: JSON.stringify({
        user_id: Number(User()?.id),
        astro_id: Number(query.data.id),
      }),
    });
    if (post.ok) {
      setSuccess(!Success());
      setTimeout(() => {
        setSuccess(!Success());
      }, 1000);
    }
  };

  return (
    <div class={style.AstroContainer}>
      <Switch>
        <Match when={query.isLoading}>
          <h1>Loading...</h1>
        </Match>
        <Match when={query.isError}>
          <h1>Error</h1>
        </Match>
        <Match when={query.isSuccess}>
          <div class={style.AstroContent}>
            <section class={style.AstroImage}>
              <img src={query.data.image} alt="Astro Image" />
              <img
                src={query.data.image}
                alt="Astro Image"
                id={style.blurImage}
              />
            </section>
            <section class={style.AstroDescr}>
              <h1 class={style.AstroName}>{query.data.name}</h1>
              <h1 class={style.AstroTemp}>
                Temperature: <span>{query.data.temperature}ºC</span>
              </h1>
              <h1 class={style.AstroCat}>
                Type: <span>{query.data.category}</span>
              </h1>
              <section class={style.AstroBuy}>
                {User()?.isLogged ? (
                  <BsCart class={style.AstroCart} onClick={() => AddToCart()} />
                ) : (
                  <p>Login to use your cart</p>
                )}
                <button>${query.data.price}</button>
              </section>
            </section>
          </div>
        </Match>
      </Switch>
      <Presence>
        {Success() && (
          <Motion.h1
            initial={{ opacity: 0 }}
            inView={{ opacity: 1, y: -30 }}
            transition={{ duration: 1 }}
            exit={{ opacity: 0 }}
            class={style.CartSuccess}
          >
            Item added to your cart!
          </Motion.h1>
        )}
      </Presence>
    </div>
  );
};

export default Astro;
