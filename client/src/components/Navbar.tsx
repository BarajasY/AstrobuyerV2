/* import { ShoppingCart, Stars, User2 } from "lucide-solid"; */
import { BsStars, BsCart } from "solid-icons/bs";
import { AiOutlineUser } from "solid-icons/ai";
import style from "../styles/Navbar.module.css";
import { Component, createSignal } from "solid-js";
import { A } from "@solidjs/router";
import { useTooltip } from "../utils/useTooltip";
import { User } from "../utils/sharedSignals";

const Navbar: Component = () => {
  const [Settings, setSettings] = createSignal(false);

  return (
    <div class={style.navbarContainer}>
      <div class={style.navbarContent}>
        <section class={style.logoSection}>
          <A href="/">
            Astrobuyer&nbsp;
            <BsStars />
          </A>
        </section>
        <section class={style.userSection}>
          <A href="/login">Login</A>
          <A href="/signup">Signup</A>

          {/*  <AiOutlineUser
            fill="#FFFFFF"
            size={25}
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
          )} */}
          {/* <BsCart
                size={25}
                onMouseOver={(e) => useTooltip("Cart", e)}
                onClick={() => setSettings(!Settings())}
              /> */}
        </section>
      </div>
    </div>
  );
};

export default Navbar;
