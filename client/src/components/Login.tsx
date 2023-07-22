import { Component, createSignal, onMount } from "solid-js";
import style from "../styles/Login.module.css";
import Cookies from "universal-cookie";
import {
  ErrorMessage,
  setErrorMessage,
  setUser,
} from "../utils/sharedSignals";
import { sha256 } from "crypto-hash";
import { useNavigate } from "@solidjs/router";

const Login: Component = () => {
  const [Email, setEmail] = createSignal("");
  const [Password, setPassword] = createSignal("");
  const cookies = new Cookies();
  const navigate = useNavigate();

  onMount(() => {
    setErrorMessage("");
  });

  const submitLogin = async () => {
    const pass = await sha256(Password());

    const post = await fetch("http://localhost:8000/user/login", {
      headers: {
        "Content-type": "application/json",
      },
      method: "POST",
      body: JSON.stringify({
        email: Email(),
        pass,
      }),
    });
    if (post.ok) {
      const data = await post.json();
      cookies.set("user", data.username);
      cookies.set("email", data.email);
      cookies.set("isLogged", true);
      setUser(cookies.getAll());
      navigate("/");
    }
    if (post.status === 409) {
      setErrorMessage("Email or Password are incorrect.");
    }
  };

  return (
    <div class={style.loginContainer}>
      <div class={style.loginContent}>
        <h1>
          Login to <span>Astrobuyer</span>
        </h1>
        <p>{ErrorMessage()}</p>
        <section>
          <article>
            <h1>Email</h1>
            <input type="text" onchange={(e) => setEmail(e.target.value)} />
          </article>
          <article>
            <h1>Password</h1>
            <input
              type="password"
              onchange={(e) => setPassword(e.target.value)}
              onkeypress={(e) => e.key === "Enter" ? submitLogin() : null}
            />
          </article>
        </section>
        <button onclick={() => submitLogin()}>Submit</button>
      </div>
    </div>
  );
};

export default Login;
