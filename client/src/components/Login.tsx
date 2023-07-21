import { Component } from "solid-js";
import style from "../styles/Login.module.css";

const Login: Component = () => {
  return (
    <div class={style.loginContainer}>
      <div class={style.loginContent}>
        <h1>
          Login to <span>Astrobuyer</span>
        </h1>
        <section>
          <article>
            <h1>Email</h1>
            <input type="text" />
          </article>
          <article>
            <h1>Password</h1>
            <input type="text" />
          </article>
        </section>
        <button>Submit</button>
      </div>
    </div>
  );
};

export default Login;
