module plant.hellodalpine.app;

import vibe.d;

void hello(HTTPServerRequest request, HTTPServerResponse response) {
	response.writeBody("Hello world from hellodalpine!");
}

void main() {
	auto router = new URLRouter();

	router.get("/", &hello);

	auto settings = new HTTPServerSettings();
	settings.port = 8080;
	settings.bindAddresses = ["0.0.0.0"];

	listenHTTP(settings, router);

	runApplication();
}
