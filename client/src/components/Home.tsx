import { Component, onMount } from "solid-js"
import style from "../styles/Home.module.css";
import { Motion } from "@motionone/solid";
import { setUser } from "../utils/sharedSignals";

const Home:Component = () => {

  onMount(() => {
    setUser(JSON.parse(localStorage.getItem("user")?? ""))
  })

  return (
    <div class={style.homeContainer}>
        <Motion.h1
        initial={{opacity: 0, y: 30}}
        inView={{opacity: 1, y: 0}}
        transition={{duration: 1}}
        >Astro<span>buyer</span></Motion.h1>
        <Motion.p
        initial={{opacity: 0, y: 30}}
        inView={{opacity: 1, y: 0}}
        transition={{delay: 1, duration: 1}}
        >Your favorite place to buy <span>planets</span></Motion.p>
    </div>
  )
}

export default Home
