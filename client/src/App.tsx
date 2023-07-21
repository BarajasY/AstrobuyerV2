import { Component } from "solid-js";
import Home from "./components/Home";
import Store from "./components/Store";
import { QueryClientProvider, QueryClient } from "@tanstack/solid-query";
import Navbar from "./components/Navbar";
import { Route, Router, Routes } from "@solidjs/router";

const App: Component = () => {
  const queryclient: QueryClient = new QueryClient();

  return (
    <QueryClientProvider client={queryclient}>
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
        </Routes>
      </Router>
    </QueryClientProvider>
  );
};

export default App;
