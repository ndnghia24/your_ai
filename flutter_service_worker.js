'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "f393d3c16b631f36852323de8e583132",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"version.json": "fdbd2d2fe9a8a07dedd7c9ae868881e0",
"flutter_bootstrap.js": "ad93ddb58ef0273b85fad32c2d04959f",
"manifest.json": "4c85ce0ee378ecca105713c6e39c080f",
"main.dart.js": "5fce08c52024b7e160e6574607c10a8a",
"index.html": "f0cdffd22cbb2ca2f65099e438f7880c",
"/": "f0cdffd22cbb2ca2f65099e438f7880c",
"assets/AssetManifest.json": "51869cdf84da130389d5c54d8bb4bd1a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/fonts/MaterialIcons-Regular.otf": "dc8dbd03ee130b50634184d3fb540eed",
"assets/AssetManifest.bin": "628f358936608cc9752e8a62691967c4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "eaeda24da11655acb78f188cee885532",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/FontManifest.json": "2ed052a3f17675fb3ae2c32c1d1b5911",
"assets/AssetManifest.bin.json": "36c02d2f1f59ef7288c82d06731a8daa",
"assets/NOTICES": "81a13a8c52fabbc8f1f857f57faf7672",
"assets/assets/images/op_emailresponse.png": "62d5235dd166fb6caeca8c22d4afa6b2",
"assets/assets/images/google_logo.png": "5041c2d41162b1bf59264b144fdaa9d9",
"assets/assets/images/op_newchat.png": "f3ede2d7cecec8669f328ddfd7e2b385",
"assets/assets/images/op_ads.png": "f3c846f6fc4e0c429fb38efd0c384613",
"assets/assets/images/ic_down.png": "ae826907666d6731b31c16804317f516",
"assets/assets/images/op_allchat.png": "109a63978b6546f044bded76997d20a3",
"assets/assets/images/yourai_logo.png": "eb9d1be769ca8e5c9630792dc8347b83",
"assets/assets/images/loading_capoo.gif": "d927663d9bb1af8d48cd2f23212eed51",
"assets/assets/images/ic_back.png": "d2e5eab70653c1659439ec4acf8c71fe",
"assets/assets/images/ic_next.png": "7d9d0f6d24c9c707c9391c19434b43f8",
"assets/assets/images/ic_more.png": "e438b0d787323151480db2123d2f7900",
"assets/assets/images/op_knowledgebase.png": "fa7a2c931fa1228b58e951c5c5b036f9",
"assets/assets/images/ic_send.png": "3555e19c7ad9cf01fa2f1e387f8bd364",
"assets/assets/images/op_chatbot.png": "05da3b15b9031c1ee93897de9e3f841c",
"assets/assets/images/ic_menu.png": "fa83ebd24b0c025747d03259c045a626",
"assets/assets/fonts/SanFrancisco-Regular.ttf": "2ea2d54d2054b3f78a9c00261ea47f6a",
"assets/assets/svgs/gpt-4o.svg": "95bcce2674fe77a8a4e8e200267ac56c",
"assets/assets/svgs/gpt-4o-mini.svg": "b69c39c8d7038dd723b4e8cdce362eeb",
"assets/assets/svgs/gemini-1.5-pro-latest.svg": "7fe142092c15df5a5239b6046ea31b9f",
"assets/assets/svgs/claude-3-haiku-20240307.svg": "16ccd422438f2d3b6d8ad36a1efc7c46",
"assets/assets/svgs/custom-chatbot.svg": "5c79fd29a1ecca88867b8c0db15ca220",
"assets/assets/svgs/gemini-1.5-flash-latest.svg": "c80943dab73ecd40f03dde9315f75664",
"assets/assets/svgs/claude-3-sonnet-20240229.svg": "77576ae9f35d34e056ae596d4c48eba9",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"favicon.png": "5dcef449791fa27946b3d35ad8803796"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
