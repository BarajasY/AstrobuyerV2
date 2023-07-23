import { Component, For, Match, Switch } from "solid-js"
import style from "../styles/Astro.module.css";
import { useQuery } from "../utils/utils";
import { useParams } from "@solidjs/router";

const Astro:Component = () => {
  const params = useParams();
  const query = useQuery("GetOneAstro", `http://localhost:8000/astros/${params.id}`)

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
              <img src={query.data.image} alt="Astro Image"/>
            </section>
            <section class={style.AstroDescr}>
              <h1 class={style.AstroName}>{query.data.name}</h1>
              <h1 class={style.AstroTemp}>Temperature: <span>{query.data.temperature}ºC</span></h1>
              <h1 class={style.AstroCat}>Type: <span>{query.data.category}</span></h1>
              <h1 class={style.AstroPrice}>${query.data.price}</h1>
            </section>
          </div>
        </Match>
      </Switch>
    </div>
  )
}

export default Astro
