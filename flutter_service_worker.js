'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/assets/AssetManifest.json": "26eebc5b26575f9c1e54831001beaa33",
"/assets/assets/github.png": "3e54ed15b9cd877c5223f5ecf64579df",
"/assets/assets/personal_photo.jpg": "af94f41300e4c0f6121b924e669bb739",
"/assets/assets/personal_photo1.jpg": "037e579bb0d49fc6202b1539125d6603",
"/assets/assets/personal_photo2.jpg": "df07a21b86e9d1f28170a321e5080a33",
"/assets/assets/test_pic.png": "33274a71ccd45a0df7fcf110980dbbe6",
"/assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/github.png": "3e54ed15b9cd877c5223f5ecf64579df",
"/assets/LICENSE": "2858a6dcc58080e5389ea38aa9657ac7",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/personal_photo.jpg": "af94f41300e4c0f6121b924e669bb739",
"/assets/personal_photo1.jpg": "037e579bb0d49fc6202b1539125d6603",
"/assets/personal_photo2.jpg": "df07a21b86e9d1f28170a321e5080a33",
"/assets/test_pic.png": "33274a71ccd45a0df7fcf110980dbbe6",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/index.html": "3216e4eace6afd7e9ef6d1ef7b1246c8",
"/main.dart.js": "2789b3c1d007c2b3ef10ba5e70161e3a",
"/manifest.json": "14e919b7b1dde549ab334b7ee3ce8412"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
