self.addEventListener("fetch", event => {
    event.respondWith((async () => {

        const response = await fetch(event.request);
        const type = response.headers.get("content-type") || "";

        if (!type.includes("text/html")) {
            return response;
        }

        let text = await response.text();

        const inject = `
<link rel="icon" href="https://www.gstatic.com/classroom/ic_product_classroom_32.png">
<title>Home - Classroom</title>

<script>
(function(){

if(window.__panic_loaded) return;
window.__panic_loaded = true;

const img = "https://github.com/pwnmaster99/pwnmaster99.github.io/blob/main/disconnect.png?raw=true";

const overlay = document.createElement("div");
overlay.style.position = "fixed";
overlay.style.top = "0";
overlay.style.left = "0";
overlay.style.width = "100vw";
overlay.style.height = "100vh";
overlay.style.background = "black";
overlay.style.zIndex = "999999999";
overlay.style.display = "none";
overlay.style.pointerEvents = "none";

const image = document.createElement("img");
image.src = img;
image.style.position = "absolute";
image.style.top = "0";
image.style.left = "0";
image.style.width = "100%";
image.style.height = "100%";
image.style.objectFit = "cover";   // fills entire viewport
image.style.userSelect = "none";
image.style.pointerEvents = "none";

overlay.appendChild(image);

document.addEventListener("DOMContentLoaded", () => {
    document.body.appendChild(overlay);
});

document.addEventListener("keydown", e => {

    if(e.ctrlKey && e.shiftKey && e.key.toLowerCase() === "d"){

        if(overlay.style.display === "none"){
            overlay.style.display = "block";
        } else {
            overlay.style.display = "none";
        }

    }

});

})();
</script>
`;

        text = text.replace("<head>", "<head>" + inject);

        return new Response(text, {
            headers: { "content-type": "text/html" }
        });

    })());
});