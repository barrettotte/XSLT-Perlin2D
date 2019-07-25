# XSLT-Perlin2D


A 2D perlin noise SVG generator using XSLT 2.0 and self loathing.


I tried to stay as close to XSLT 1.0 as sanely as I could. This very well could still be built using XALAN processor.


Ken Perlin's implementation http://mrl.nyu.edu/~perlin/noise/


## Building
* This was actually a huge pain to figure out which XSLT processor to use (xalan, saxon, xsltproc, etc)
* I ended up doing something gross. I used Apache Ant and Saxon9.
* To build with Saxon9 use ```build.xml```, to build with XALAN use ```build-xalan.groovy```


## Input XML
```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet href="perlin.xslt" type="text/xsl"?>
<perlin-noise>
  <settings>
    <sizeX>16</sizeX>
    <sizeY>16</sizeY>
    <seed>1234</seed>
    <frequency>6</frequency>
    <octaves>4</octaves>
  </settings>
</perlin-noise>
```


## Output SVG
* xxx


## Sources
* https://en.wikipedia.org/wiki/Perlin_noise