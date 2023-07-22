import { BsStars, BsCart } from "solid-icons/bs";
import { AiOutlineUser } from "solid-icons/ai";
import style from "../styles/Navbar.module.css";
import { Component, createSignal, onMount } from "solid-js";
import { A } from "@solidjs/router";
import { User, setUser } from "../utils/sharedSignals";
import Cookies from "universal-cookie";
import { Motion, Presence } from "@motionone/solid";

const Navbar: Component = () => {
  const [Settings, setSettings] = createSignal(false);
  const cookies = new Cookies();

  onMount(() => {
    setUser(cookies.getAll());
  });

  const LogOff = () => {
    cookies.remove("user");
    cookies.remove("email");
    cookies.remove("isLogged");
    setUser(cookies.getAll());
  };

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
          {User()?.isLogged ? (
            <>
              <p>{User()?.user}</p>
              <AiOutlineUser
                fill="#FFFFFF"
                size={25}
                onClick={() => setSettings(!Settings())}
                class={style.NavbarLoggedIcons}
              />
              <Presence>
                {Settings() && (
                  <Motion.div
                    initial={{ opacity: 0 }}
                    inView={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    class={style.SettingsContainer}
                  >
                    <A href="/profile">Profile</A>
                    <p onclick={() => LogOff()}>Logout</p>
                  </Motion.div>
                )}
              </Presence>
              <BsCart
                class={style.NavbarLoggedIcons}
                size={25}
              />
            </>
          ) : (
            <>
              <A href="/login">Login</A>
              <A href="/signup">Signup</A>
            </>
          )}
        </section>
      </div>
    </div>
  );
};

export default Navbar;
