self.addEventListener("fetch", event => {
    event.respondWith((async () => {

        const response = await fetch(event.request);

        const type = response.headers.get("content-type") || "";

        if (!type.includes("text/html")) {
            return response;
        }

        let text = await response.text();

        text = text.replace(
            "<head>",
            `<head>
<link rel="icon" href="https://www.gstatic.com/classroom/ic_product_classroom_32.png">
<title>Home - Classroom</title>`
        );

        return new Response(text, {
            headers: { "content-type": "text/html" }
        });

    })());
});