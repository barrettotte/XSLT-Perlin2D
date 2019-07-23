import javax.xml.transform.TransformerFactory
import javax.xml.transform.stream.StreamResult
import javax.xml.transform.stream.StreamSource
import javax.xml.transform.OutputKeys

def xml = new File("perlin.xml").getText()
def xslt= new File("perlin.xslt").getText()
def transformer = TransformerFactory.newInstance().newTransformer(new StreamSource(new StringReader(xslt)))
def out = new FileOutputStream("output.xml")

transformer.setOutputProperty(OutputKeys.INDENT, "yes");
transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "2");
transformer.transform(new StreamSource(new StringReader(xml)), new StreamResult(out))