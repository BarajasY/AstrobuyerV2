export type Astro = {
    id: number,
    name: string,
    price: number,
    category: string,
    temperature:number,
    image: string
}

export type User = {
    user: string,
    password: string,
    email: string
}

export type UserClient = {
    user: string,
    email: string,
    isLogged: boolean
}
