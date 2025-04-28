'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/android/assets/images/level1/exercise1.gif": "de372d374f06f8fa1bba554f54b7b0ef",
"assets/android/assets/images/level1/exercise10.gif": "07d5a63415d056b8fd62eee3f820abda",
"assets/android/assets/images/level1/exercise2.gif": "f61e4caafe174ef77bc262d8d9baa334",
"assets/android/assets/images/level1/exercise3.gif": "09cf3aabf80834a680c57b5ab8063f8e",
"assets/android/assets/images/level1/exercise4.gif": "ea02fe125f335911e9272053e97f282b",
"assets/android/assets/images/level1/exercise5.gif": "d95105f42e466b464b49faa18f6b9825",
"assets/android/assets/images/level1/exercise6.gif": "c23006c3e3b15cbdf5928e2e454d49b4",
"assets/android/assets/images/level1/exercise7.gif": "21601449d7c4280f851abc1cd6f4fc18",
"assets/android/assets/images/level1/exercise8.gif": "663d77c500bc41ff3aef36ac2924fbc4",
"assets/android/assets/images/level1/exercise9.gif": "0292c11b952d0ebbfbad8f1f99747b45",
"assets/android/assets/images/level2/exercise11.gif": "eac5d6b7634e4526ac6316286d9465c1",
"assets/android/assets/images/level2/exercise12.gif": "e4115e938136410f46c7bf28797ded77",
"assets/android/assets/images/level2/exercise13.gif": "16a1dab70b89d8f950aa5eb92ce732b0",
"assets/android/assets/images/level2/exercise14.gif": "705580b5b54bb0496ed50163f48b36dc",
"assets/android/assets/images/level2/exercise15.gif": "86bc70226608fbf6d8a330974d8bb9e5",
"assets/android/assets/images/level2/exercise16.gif": "852dcd4f80d1a76782f661ee33ea68c8",
"assets/android/assets/images/level2/exercise17.gif": "43b6dd920252c64a7f1dfac95366d548",
"assets/android/assets/images/level2/exercise18.gif": "c049a1ea15d1c6adc2b2e2b9195c5196",
"assets/android/assets/images/level2/exercise19.gif": "e028d8bf28f488ecf453390200e27991",
"assets/android/assets/images/level2/exercise20.gif": "9832371ba885ccb6f50316f2ba4cc288",
"assets/android/assets/images/level3/exercise21.gif": "cdcdd56fded1b96724874b85605998bf",
"assets/android/assets/images/level3/exercise22.gif": "0e9d5bf33db41ce82a8b9780c5c44aac",
"assets/android/assets/images/level3/exercise23.gif": "b7d3400eea331832c3e538627e545802",
"assets/android/assets/images/level3/exercise24.gif": "5c0f09fbdd132553541bb76ccb44ed70",
"assets/android/assets/images/level3/exercise25.gif": "dc8dca0db583926e78b6ea3177d08549",
"assets/android/assets/images/level3/exercise26.gif": "5fc02bc504b9cd3f7322706668cc7986",
"assets/android/assets/images/level3/exercise27.gif": "37c443ca7ebd57100cb427009044e5d4",
"assets/android/assets/images/level3/exercise28.gif": "f5145fbef728963a5ffa797f42e167eb",
"assets/android/assets/images/level3/exercise29.gif": "3443f55c402b21aaa132e7a5809d7900",
"assets/android/assets/images/level3/exercise30.gif": "c89b923f265ac332cefcbe783756a3bd",
"assets/android/assets/images/main_screen_image1.jpg": "49de03b185bdcea45585c53e2bf3cc1d",
"assets/android/assets/images/main_screen_image2.jpg": "4ae1030bfab9ca4b172a312e87982f35",
"assets/AssetManifest.bin": "4ec3ba0c824d895bed5ebad487ba8574",
"assets/AssetManifest.bin.json": "9e9516137d29f18237c6557d3b203bb5",
"assets/AssetManifest.json": "3e5cf221299f2cda808cd7afe961fc7d",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "51fb1550515d07ca984ab729abf0aa79",
"assets/NOTICES": "207434406ab69defd7eb53737cc67499",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "ae2772c3a041dd5ee05b68836f4f4e4e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "294aa7f2971c66e0a310b46cf6495d83",
"/": "294aa7f2971c66e0a310b46cf6495d83",
"main.dart.js": "d9ac54496b513c3ae674cb24a1a66ae9",
"manifest.json": "c2f5cfea92cb3274340e02ce62ec26fe",
"version.json": "22384e1e71e8f278449ab00c434a3c60"};
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
