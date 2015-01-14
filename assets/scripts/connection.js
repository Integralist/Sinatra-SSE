var evtSource = new EventSource("/healthcheck");

evtSource.onmessage = function(e) {
    console.log("onmessage", e.data);
};

evtSource.addEventListener("ping", function(e) {
    console.log("ping", e.data);
}, false);

evtSource.onerror = function(e) {
    console.log("error", e);
};
