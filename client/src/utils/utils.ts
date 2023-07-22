import { createMutation, createQuery } from "@tanstack/solid-query";

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

export function useMutation(mutationName:string, url:string,  data:any) {
    const mutation = createMutation({
        mutationKey: [mutationName],
        mutationFn: async () => {
            const post = await fetch(url, {
                method: "POST",
                headers: {
                    "Content-type": "application/json"
                },
                body:JSON.stringify(data)
            })
            if (post.ok) {
                return post.json();
            }
        },
    })
    return mutation;
}
