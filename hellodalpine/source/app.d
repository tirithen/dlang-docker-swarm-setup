module plant.hellodalpine.app;

import vibe.d;

void errorHandler(HTTPServerRequest request, HTTPServerResponse response, HTTPServerErrorInfo error) {
	response.statusCode = error.code;
	response.writeBody(error.code.to!string ~ " " ~ error.message ~ "\n" ~ request.requestURI ~ "\n" ~ request.headers.toString());

	if (error.code >= 500) {
		logError(error.debugMessage);
	}
}

void hello(HTTPServerRequest request, HTTPServerResponse response) {
	response.writeBody("Hello world from hellod!" ~ "\n" ~ request.requestURI ~ "\n" ~ request.headers.toString());
}

void main() {
	auto router = new URLRouter();

	router.get("/", &hello);

	auto settings = new HTTPServerSettings();
	settings.port = 8080;
	settings.bindAddresses = ["0.0.0.0"];
	settings.errorPageHandler = toDelegate(&errorHandler);

	listenHTTP(settings, router);

	runApplication();
}
