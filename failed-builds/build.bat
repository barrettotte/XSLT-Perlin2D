@ECHO OFF

REM Opening and closing browser got super annoying...
REM "C:\Program Files (x86)\Google\Chrome\Application\chrome" --allow-file-access-from-files --new-window file:///C:/_Personal/xslt/perlin.xml


REM Need to be able to call basic Java functions (Math:random())
REM java -jar c:\saxon\saxon9he.jar -s:perlin.xml -xsl:perlin.xslt -o:out.xhtml


REM Cant figure out how to get maxdepth working...
REM xsltproc --maxdepth 1048576‬ -o out.xml perlin.xslt perlin.xml 


REM XSLT 2.0 with Saxon doesn't allow java calls (Math:random())
REM ant build


REM Lets see if groovy works
groovy build.groovy