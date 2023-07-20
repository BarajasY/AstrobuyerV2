import { onMount, type Component, createSignal } from 'solid-js';
import logo from './logo.svg';
import styles from './styles/App.module.css';
import {sha256} from "crypto-hash";
import Home from './components/Home';
import Store from './components/Store';
import { NumSignal } from './sharedSignals';

const App: Component = () => {
  return (
    <div class={styles.App}>
      <Home />
      <Store />
    </div>
  );
};

export default App;
