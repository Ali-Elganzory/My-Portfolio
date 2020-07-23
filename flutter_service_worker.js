'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "20af3229997991775d68d92523a09e27",
"assets/assets/fonts/GochiHand-Regular.ttf": "9b48452cfcc1da9b1f684f991cb3d1e3",
"assets/assets/fonts/Rowdies-Bold.ttf": "3cd3cfa6a2e9e746f586b67120d661fe",
"assets/assets/fonts/Rowdies-Light.ttf": "e4558190154456c237c0432c380ef08b",
"assets/assets/fonts/Rowdies-Regular.ttf": "b2a024dc5716bc92b5496d87f05ad216",
"assets/assets/images/fly_food/1.png": "ec39a179975c6ec3677eefb6db63010b",
"assets/assets/images/fly_food/2.png": "c8aec2ce4f59e3d9fd9f5deb833d1cd3",
"assets/assets/images/fly_food/3.png": "13cfbf2a66e10dd7929aadc809e7b305",
"assets/assets/images/fly_food/4.png": "5c6b413261593e333ec7899ad1c9d7f5",
"assets/assets/images/fly_food/5.png": "b960558002ec5d8635e834ea4a12dccc",
"assets/assets/images/personal_photo.jpg": "93937af8f9f160fcfe10d5b8994e9f5a",
"assets/assets/images/test/1.png": "33274a71ccd45a0df7fcf110980dbbe6",
"assets/assets/images/test/2.png": "33274a71ccd45a0df7fcf110980dbbe6",
"assets/assets/images/test/3.png": "33274a71ccd45a0df7fcf110980dbbe6",
"assets/assets/images/test/4.png": "33274a71ccd45a0df7fcf110980dbbe6",
"assets/assets/images/u_turn/1.png": "5f4bb14fe1aa5a10f7706eb5f1a55188",
"assets/assets/images/u_turn/2.png": "c3b31e55677b53ba1b02a755c9a6880e",
"assets/assets/images/u_turn/3.png": "e56f31948d0322cbfefec1ade8c6079a",
"assets/assets/images/u_turn/4.png": "06f84d354d554284d0b634fc44ed0a1a",
"assets/assets/images/u_turn/5.png": "136fd74db859601c4a598fe21d551dd5",
"assets/FontManifest.json": "eff8c446fa18dc69a1b70054fc36eae1",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/github.png": "3e54ed15b9cd877c5223f5ecf64579df",
"assets/NOTICES": "c77de997afa5249e63784b36531e85ef",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/personal_photo.jpg": "af94f41300e4c0f6121b924e669bb739",
"assets/personal_photo1.jpg": "037e579bb0d49fc6202b1539125d6603",
"assets/personal_photo2.jpg": "df07a21b86e9d1f28170a321e5080a33",
"assets/test_pic.png": "33274a71ccd45a0df7fcf110980dbbe6",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "3216e4eace6afd7e9ef6d1ef7b1246c8",
"/": "3216e4eace6afd7e9ef6d1ef7b1246c8",
"main.dart.js": "3140b71e7e6142d8b912ddb285682429",
"manifest.json": "14e919b7b1dde549ab334b7ee3ce8412"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a no-cache param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'no-cache'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');

      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }

      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'no-cache'});
        return response || fetch(modifiedRequest).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    return self.skipWaiting();
  }

  if (event.message === 'downloadOffline') {
    downloadOffline();
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
