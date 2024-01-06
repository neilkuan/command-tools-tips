## Nodejs get timeZoneOffset change to +/- 0:00 
https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
```js
var x = new Date();
var offset= -x.getTimezoneOffset();
console.log((offset>=0?"+":"")+parseInt(offset/60)+":"+String(offset%60).padStart(2, "0"))

--- ---
docker run -ti --rm --entrypoint "" -e "TZ=UTC" -v $PWD/index.js:/tmp/index.js public.ecr.aws/docker/library/node:latest node /tmp/index.js
+0:00
docker run -ti --rm --entrypoint "" -e "TZ=Asia/Taipei" -v $PWD/index.js:/tmp/index.js public.ecr.aws/docker/library/node:latest node /tmp/index.js
+8:00
docker run -ti --rm --entrypoint "" -e "TZ=America/Los_Angeles" -v $PWD/index.js:/tmp/index.js public.ecr.aws/docker/library/node:latest node /tmp/index.js
-8:00
--- ---
```
