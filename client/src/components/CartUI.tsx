import { For, Match, Switch, createSignal, onMount } from "solid-js";
import style from "../styles/CartUI.module.css";
import { User, setOpenCart } from "../utils/sharedSignals";
import { useQuery } from "../utils/utils";
import { Astro } from "../utils/types";
import { Motion, Presence } from "@motionone/solid";
import { AiOutlineClose } from "solid-icons/ai";
import { BsTrash } from "solid-icons/bs";

const CartUI = () => {
  const [CartTotal, setCartTotal] = createSignal<number>(0);

  const query = useQuery(
    "FetchCart",
    `http://localhost:8000/cart/get/${User()?.id}`
  );

  onMount(() => {
    const test: Astro[] = query.data;
    if (test.length < 1) {
      setCartTotal(0);
    } else {
      for (let i = 0; i < test.length; i++) {
        setCartTotal(CartTotal() + test[i].price);
      }
    }
  });

  const deleteFromCart = async (id:number) => {
    const post = await fetch("http://localhost:8000/cart/delete", {
      headers: {
        "Content-Type": "application/json",
      },
      method: "POST",
      body: JSON.stringify({
        user_id: User()?.id,
        astro_id: id
      })
    })
    if(post.ok) {

    }
  }

  return (
    <Presence>
      <Motion.div
        initial={{ opacity: 0 }}
        inView={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        class={style.CartContainer}
      >
        <Switch>
          <Match when={query.isLoading}>
            <h1>Loading...</h1>
          </Match>
          <Match when={query.isError}>
            <h1>Error, our team is working on it!</h1>
          </Match>
          <Match when={query.isSuccess}>
            <Motion.div exit={{ opacity: 0 }} class={style.CartContent}>
              <section class={style.CloseCart}>
                <AiOutlineClose
                  class={style.CloseCartIcon}
                  size={30}
                  onClick={() => setOpenCart(false)}
                />
              </section>
              <p>Cart</p>
              <div class={style.CartAstros}>
                {query.data.length < 1 ? (
                  <h1>No results found</h1>
                ) : (
                  <For each={query.data}>
                    {(astro: Astro) => (
                      <div class={style.AstroContent}>
                        <img src={astro.image} alt={astro.name} />
                        <h1>{astro.name}</h1>
                        <h1>{astro.category}</h1>
                        <h1>{astro.price}</h1>
                        <BsTrash class={style.deleteIcon} onClick={() => deleteFromCart(astro.id)}/>
                      </div>
                    )}
                  </For>
                )}
              </div>
              <button class={style.TotalButton}>{CartTotal()}</button>
            </Motion.div>
          </Match>
        </Switch>
      </Motion.div>
    </Presence>
  );
};

export default CartUI;
