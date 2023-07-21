import style from "../styles/Store.module.css";
import { Astro } from "../utils/types";
import { useQuery } from "../utils/useQuery";
import { Switch, Match, For } from "solid-js";
import { Thermometer } from "lucide-solid";
import ShopFilters from "./ShopFilters";

const Store = () => {
  const query = useQuery("GetAstros", "http://localhost:8000/astros");

  return (
    <div class={style.storeContainer}>
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
                  <div class={style.shopItem}>
                    <img src={astro.image} alt="Astro" />
                    <section>
                      <h1>{astro.name}</h1>
                      <h1>${astro.price}</h1>
                    </section>
                    <h1 class={style.fullWidth}>{astro.category}</h1>
                    <h1 class={style.fullWidth}>
                      <Thermometer size={28} strokeWidth={3} />
                      {astro.temperature}
                    </h1>
                  </div>
                )}
              </For>
            </div>
          </Match>
        </Switch>
      </div>
      <ShopFilters />
    </div>
  );
};

export default Store;
