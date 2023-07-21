import {Component} from "solid-js";
import styles from "./styles/App.module.css";
import Home from "./components/Home";
import Store from "./components/Store";
import { QueryClientProvider, QueryClient } from "@tanstack/solid-query";

const App:Component = () => {
  const queryclient:QueryClient = new QueryClient();

  return (
    <QueryClientProvider client={queryclient}>
      <div class={styles.App}>
        <Home />
        <Store />
      </div>
    </QueryClientProvider>
  );
};

export default App;
