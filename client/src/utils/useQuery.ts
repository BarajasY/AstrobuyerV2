import { createQuery } from "@tanstack/solid-query";

export function useQuery(queryName:string, queryUrl:string) {
    const query = createQuery(
        () =>[queryName],
        async () => {
            const data = await fetch(queryUrl)
            const json = await data.json();
            return json;
        }
    )
    return query;
}
