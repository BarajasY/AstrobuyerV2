import { Component, createSignal } from "solid-js";
import style from "../styles/Signup.module.css";
import { sha256 } from "crypto-hash";

const Signup: Component = () => {
  const [Password, setPassword] = createSignal<string>("");
  const [Username, setUsername] = createSignal<string>("");
  const [Email, setEmail] = createSignal<string>("");

  const submitUser = async () => {
    const data = {
      username: Username(),
      pass: await sha256(Password()),
      email: await sha256(Email())
    }
    console.log(data);
    const post = await fetch("http://localhost:8000/user/create", {
      headers: {
        "Content-type": "application/json"
      },
      method: "POST",
      body: JSON.stringify(data)
    })
    if(post.ok) {
      console.log("Success!")
    }
  }

  return (
    <div class={style.signupContainer}>
      <div class={style.signupContent}>
        <h1>
          Create an <span>account</span> with us!
        </h1>
        <section>
          <article>
            <p>Username</p>
            <input type="text" onchange={(e) => setUsername(e.target.value)}/>
          </article>
          <article>
            <p>Email</p>
            <input type="text" onchange={(e) => setEmail(e.target.value)}/>
          </article>
          <article>
            <p>Password</p>
            <input type="password" onchange={(e) => setPassword(e.target.value)}/>
          </article>
        </section>
        <button onClick={() => submitUser()}>Submit</button>
      </div>
    </div>
  );
};

export default Signup;
