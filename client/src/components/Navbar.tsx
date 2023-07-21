import { ShoppingCart, Stars, User2 } from "lucide-solid";
import style from "../styles/Navbar.module.css";
import { useTooltip } from "../utils/useTooltip";
import { createSignal } from "solid-js";
import { A } from "@solidjs/router";

const Navbar = () => {
  const [Settings, setSettings] = createSignal(false);

  return (
    <div class={style.navbarContainer}>
      <div class={style.navbarContent}>
        <section class={style.logoSection}>
          <h1>
            Astrobuyer&nbsp;
            <Stars size={20} strokeWidth={2} />
          </h1>
        </section>
        <section class={style.userSection}>
          <User2
            size={25}
            strokeWidth={2}
            class={style.profileIcon}
            onMouseOver={(e) => useTooltip("Profile", e)}
            onClick={() => setSettings(!Settings())}
          />
          {Settings() && (
            <div class={style.SettingsContainer}>
              <h1>Hola</h1>
              <A href="./profile">Profile</A>
              <h1>Hola</h1>
              <h1>Hola</h1>
            </div>
          )}
          <ShoppingCart
            size={25}
            strokeWidth={2}
            class={style.cartIcon}
            onMouseOver={(e) => useTooltip("Cart", e)}
          />
        </section>
      </div>
    </div>
  );
};

export default Navbar;
