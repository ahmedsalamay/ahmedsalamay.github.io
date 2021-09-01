'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "719b2f1ac671102f273302542fbd1ca9",
"assets/assets/images/01.png": "336486be294a617abfce00b0d6e999a5",
"assets/assets/images/BACKGROUND.png": "f0c22daafe9ba645ac14859c915e3a97",
"assets/assets/images/classic.png": "1354ef1769b55e3f28bbbf8aa9e02fb5",
"assets/assets/images/clean.png": "12f701934eee7f9099558592be8c3599",
"assets/assets/images/confirm.png": "87cd7d36ba941b628bc5693b339dd17f",
"assets/assets/images/congratulations.png": "f22794e5f1c61bb9431ba84f6e700747",
"assets/assets/images/down-arrow.png": "e728d094f094bd9a2860b4109d1674c6",
"assets/assets/images/egypt.png": "da4bdaf28b686b0675119096620804b6",
"assets/assets/images/etisalat.png": "bb00f02aaba6cd3c005dba59e1f0315d",
"assets/assets/images/facebook.png": "a36ec7d47180546e220751fd068531a5",
"assets/assets/images/facebookGrey.png": "795e917cb6059aa57b0694ca3554ba50",
"assets/assets/images/gift.png": "e7eeea85906cc42a1bb23019230b93e5",
"assets/assets/images/googleGrey.png": "2f12a4ee34b9632944d7536f38c650cc",
"assets/assets/images/INSTAGRAM.png": "b2ef983c97e458b9cc1579103e21c501",
"assets/assets/images/instagram_colored.png": "15fe74724b7a614d374a8ddedb9e8fc7",
"assets/assets/images/leave_message.png": "cc5b59182b26cef6a9401fc5756458e0",
"assets/assets/images/list-text.png": "25c00ce92728d3147a68e2755f4314f6",
"assets/assets/images/logo.png": "033a9967b7c4783e6a932598606507aa",
"assets/assets/images/onboard1.png": "700506eb03c26923ae51f5f7bfbb5071",
"assets/assets/images/onboard2.png": "a03d81cf5c0a5f308bcca7c37d852341",
"assets/assets/images/onboard3.png": "78cc990d64d4bd47164dbcb4e9a730ca",
"assets/assets/images/orange.png": "757953a6871448da52182f50c31db4d3",
"assets/assets/images/permise.png": "1c86af50feb08ff179f5fa18622a7a6c",
"assets/assets/images/photo-FB.png": "94031875bf1b61f2d3495b9ab3b99faa",
"assets/assets/images/shaded.png": "9f97b2aee3c2a94062636a63f194b9b7",
"assets/assets/images/social_post.png": "cb3405f994942535d3a4b851878ca932",
"assets/assets/images/twitter.png": "be546501e6a2e2ea9fe6ae51a5e46e53",
"assets/assets/images/up_photo.png": "d975a311deb61c6c940c78befe3e0d1b",
"assets/assets/images/us.png": "d4462d96d3f5ff09b2f23f6ec0fbb965",
"assets/assets/images/vodafone.png": "32775824e41b4ace62117638381dc32f",
"assets/assets/images/wall.jpg": "9810beb4276d7ef113e11fc1dd474c1b",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "4b31c795ce7fccc3d1adfa9a2c756832",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "e183a0e623e7b53303b1f100114cdac9",
"/": "e183a0e623e7b53303b1f100114cdac9",
"loader.css": "1c9728a4d3829f25a2ce42037bc24f23",
"main.dart.js": "0f6db26e243752f044d8f212da2ae921",
"manifest.json": "ea92df44ab6ad3d5e42ace2b822d3b5c",
"version.json": "d38a3527ee3f654d4ed7b6ece9d328b5"
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
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
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
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
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
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
