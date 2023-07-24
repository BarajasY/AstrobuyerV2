import { createSignal } from "solid-js";
import { UserClient } from "./types";

export const [NumSignal, setNumSignal] = createSignal(0);
export const [User, setUser] = createSignal<UserClient>();
export const [ErrorMessage, setErrorMessage] = createSignal<string>("");
export const [OpenCart, setOpenCart] = createSignal<boolean>(false)
