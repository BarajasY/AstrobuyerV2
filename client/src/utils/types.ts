export type Astro = {
    id: number,
    name: string,
    price: number,
    category: string,
    temperature:number,
    image: string
}

export type CartAstro = {
    id: number,
    name: string,
    price: number,
    category: string,
    temperature:number,
    image: string,
    item_id: number
}

export type User = {
    user: string,
    password: string,
    email: string
}

export type UserClient = {
    id: number,
    user: string,
    email: string,
    isLogged: boolean
}
