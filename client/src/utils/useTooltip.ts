import { createMotion } from "@motionone/solid";

export const useTooltip = (text: string, e: MouseEvent) => {
    if (document.getElementsByClassName("tooltipElement").length === 0) {
        const element = document.elementFromPoint(e.clientX, e.clientY);
        const pElement = document.createElement("p")
        pElement.style.transform = "translateY(-10px)"
        pElement.style.opacity = "0"
        pElement.innerHTML = text;
        pElement.style.position = "absolute"
        pElement.style.color = "#FFFFFF"
        pElement.style.padding = "2px 5px"
        pElement.style.background = "black"
        pElement.style.border = "2px solid var(--lightblue)"
        pElement.style.borderRadius = "5px"
        pElement.className = "tooltipElement"
        element?.after(pElement)
        createMotion(pElement, { animate: { opacity: 1, y: 5 } })
        setTimeout(() => {
            createMotion(pElement, { animate: { opacity: 0, y: -10 }, transition: { duration: .2 } })
            setTimeout(() => {
                pElement.remove();
            }, 100);
        }, 400);
    }
}
