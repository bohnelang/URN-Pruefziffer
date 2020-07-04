# Einfache URN (Uniform Resource Name) Berechung in PHP und Javascript

USN-Servevice der DNB: [https://www.dnb.de/DE/Professionell/Services/URN-Service/urn-service_node.html](https://www.dnb.de/DE/Professionell/Services/URN-Service/urn-service_node.html)

In PHP kann man die URN-Prüfsumme mit einer Zeile PHP-Code berechnen - ok, es ist eine lange Zeile :-)

```
# Test-set
$test_org="urn:nbn:de:0183-mbi0003721";
$test_urn=substr($test_org,0,-1);

# Here: One line of code for calculation...
for($code="3947450102030405060708094117############1814191516212223242542262713282931123233113435363738########43", $i=$sum=0, $pos=1; $i<strlen($test_urn); $i++, $sum += ($v1==0)?$v2*$pos++:$pos++*$v1+$v2*$pos++, $purn=$sum/$v2 % 10) list($v1,$v2)=array(substr($code,(ord(strtoupper(substr($test_urn,$i,1)))-45)*2,1),substr($code,(ord(strtoupper(substr($test_urn,$i,1)))-45)*2+1,1));

# Output / Check
printf("%s %s => %s (%s)\n", $test_urn,$purn,$test_urn.$purn,$test_urn.$purn==$test_org?"OK":"Error");

```



