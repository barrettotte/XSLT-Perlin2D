# XSLT-Perlin2D


A 2D perlin noise SVG generator using XSLT 1.1 and self loathing.


Ken Perlin's implementation http://mrl.nyu.edu/~perlin/noise/


## Input XML
```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet href="perlin.xslt" type="text/xsl"?>
<perlin-noise>
  <settings>
    <title>2D Perlin Noise</title>
    <size x="64" y="64"/>      
  </settings>
</perlin-noise>
```


## Run
* This was actually a huge pain to figure out which XSLT processor to use (xalan, saxon, xsltproc, etc)
* ```groovy build.groovy```



## Output XML
* xxx


## Sources
* https://en.wikipedia.org/wiki/Perlin_noise