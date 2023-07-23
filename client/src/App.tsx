import { Component, lazy } from "solid-js";
import { QueryClientProvider, QueryClient } from "@tanstack/solid-query";
import { Route, Router, Routes } from "@solidjs/router";
const Login =lazy(() => import("./components/Login"));
const Home =lazy(() => import("./components/Home"));
const Store =lazy(() => import("./components/Store"));
const Navbar =lazy(() => import("./components/Navbar"));
/* const Signup =lazy(() => import("./components/Signup")); */
import Signup from "./components/Signup";
import Astro from "./components/Astro";

const App: Component = () => {

  return (
      <Router>
        <Routes>
          <Route
            path="/"
            element={
              <>
                <Navbar /> <Home /> <Store />
              </>
            }
          />
          <Route
            path="/login"
            element={
              <>
                <Navbar /> <Login />
              </>
            }
          />
          <Route
            path="/signup"
            element={
              <>
                <Navbar /> <Signup />
              </>
            }
          />
          <Route
            path="/:id"
            element={
              <>
                <Navbar /> <Astro />
              </>
            }
          />
        </Routes>
      </Router>
  );
};

export default App;
