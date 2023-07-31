import { Component, createSignal } from "solid-js";
import style from "../styles/Signup.module.css";
import { sha256 } from "crypto-hash";
import Cookies from "universal-cookie";
import { useNavigate } from "@solidjs/router";
import { setUser } from "../utils/sharedSignals";

const Signup: Component = () => {
  const [Password, setPassword] = createSignal<string>("");
  const [Username, setUsername] = createSignal<string>("");
  const [Email, setEmail] = createSignal<string>("");
  const cookies = new Cookies();
  const navigate = useNavigate();

  const submitUser = async () => {
    const post = await fetch("http://localhost:8000/user/create", {
      headers: {
        "Content-type": "application/json",
      },
      method: "POST",
      body: JSON.stringify({
        username: Username(),
        pass: await sha256(Password()),
        email: Email(),
      }),
    });
    if (post.ok) {
      const data = await post.json();
      cookies.set("user", data.username);
      cookies.set("email", data.email);
      cookies.set("id", data.id);
      cookies.set("isLogged", true);
      setUser(cookies.getAll());
      navigate("/");
    }
  };

  return (
    <div class={style.signupContainer}>
      <div class={style.signupContent}>
        <h1>
          Create an <span>account</span> with us!
        </h1>
        <section>
          <article>
            <p>Username</p>
            <input type="text" onchange={(e) => setUsername(e.target.value)} />
          </article>
          <article>
            <p>Email</p>
            <input type="text" onchange={(e) => setEmail(e.target.value)} />
          </article>
          <article>
            <p>Password</p>
            <input
              type="password"
              onchange={(e) => setPassword(e.target.value)}
              onkeypress={(e) => e.key === "Enter" ? submitUser() : null}
            />
          </article>
        </section>
        <button onClick={() => submitUser()}>Submit</button>
      </div>
    </div>
  );
};

export default Signup;
