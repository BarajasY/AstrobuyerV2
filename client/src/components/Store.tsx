import style from "../styles/Store.module.css";
import { Astro } from "../utils/types";
import { useQuery } from "../utils/utils";
import { Switch, Match, For, Component } from "solid-js";
import { useNavigate } from "@solidjs/router";

const Store: Component = () => {
  const query = useQuery("GetAstros", "http://localhost:8000/astros");
  const navigate = useNavigate();

  return (
    <div class={style.storeContainer}>
      <h1>Shop</h1>
      <div class={style.wrapper}>
        <div class={style.shopWrapper}>
          <Switch>
            <Match when={query.isLoading}>
              <h1>Loading...</h1>
            </Match>
            <Match when={query.isError}>
              <h1>404 Error. Working on it</h1>
            </Match>
            <Match when={query.isSuccess}>
              <div class={style.AstroShop}>
                <For each={query.data}>
                  {(astro: Astro) => (
                    <div class={style.shopItem} onClick={() => navigate(`/${astro.id}`)}>
                      <div class={style.astroCategoryContainer}>
                        <h1
                          class={style.astroCategory}
                          style={{ "font-size": "20px", color: "white" }}
                        >
                          {astro.category}
                        </h1>
                      </div>
                      <img src={astro.image} alt="Astro" />
                      <section>
                        <h1>{astro.name}</h1>
                        <h1>${astro.price}</h1>
                      </section>
                    </div>
                  )}
                </For>
              </div>
            </Match>
          </Switch>
        </div>
      </div>
    </div>
  );
};

export default Store;
