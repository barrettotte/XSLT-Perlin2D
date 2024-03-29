# XSLT-Perlin2D


A 2D perlin noise SVG generator using XSLT 2.0 and self loathing.


Its ugly, slow, and I'm sorry for bringing it into existence.


## Build
* This was actually a huge pain to figure out which XSLT processor to use (xalan, saxon, xsltproc, etc)
* I ended up doing something gross. I used Apache Ant and Saxon9.
* To build with Saxon9 (XSLT 2.0) use ```ant``` **Recommended**
* Can also be built with XALAN (XSLT 1.0) use ```groovy build-xalan.groovy``` but its runs terribly at greater than 128x128 size


## Generated SVG
![perlin-screenshot](screenshot.PNG)


## Input XML (```perlin-svg.xml```)
```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet href="perlin.xslt" type="text/xsl"?>
<perlin-noise>
  <settings>
    <sizeX>256</sizeX>
    <sizeY>256</sizeY>
    <seed>1234</seed>
    <frequency>6</frequency>
    <octaves>4</octaves>
  </settings>
</perlin-noise>
```


## Generated Perlin noise XML ```example-perlin.xml```
Sample of perlin noise data that is generated before transforming to SVG.



## Output SVG ```perlin.svg```
```xml
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="256" height="256" viewBox="0 0 256 256">
  <rect x="1" y="1" width="1" height="1" fill="rgb(66,66,66)"/>
  <rect x="2" y="1" width="1" height="1" fill="rgb(61,61,61)"/>
  <rect x="3" y="1" width="1" height="1" fill="rgb(180,180,180)"/>
  <rect x="4" y="1" width="1" height="1" fill="rgb(160,160,160)"/>
  <!-- ... -->
</svg>
```


## XSLT Descriptions
| File Name | Description |
| --------- | ----------- |
| hash.xslt | Pre-computed hashes for generating perlin noise |
| map.xslt  | Create map data structure of pixels |
| noise.xslt | Generate 2D Perlin noise |
| perlin-svg.xslt | Driver |
| svg-utils.xslt | Utils for SVG generation and color value conversion |
| utils.xslt | General utils |


## Sources
* Ken Perlin's implementation http://mrl.nyu.edu/~perlin/noise/
* https://en.wikipedia.org/wiki/Perlin_noise
* https://codepen.io/shshaw/post/vector-pixels-svg-optimization-animation-and-understanding-path-data
