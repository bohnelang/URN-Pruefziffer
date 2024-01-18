# Einfache URN (Uniform Resource Name) Prüfziffern-Berechnung für den Namensraum nbn / Überprüfung in PHP und Javascript

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

Or Javascript:
```
function calc_urn_checksum(test_urn)
{
        //var test_urn='urn:nbn:de:hbz:79pbc-201405121';
        var code='3947450102030405060708094117############1814191516212223242542262713282931123233113435363738########43';
        for(var i=0,sum=0,pos=1; i<test_urn.length;i++){
                var x=test_urn.toUpperCase().charCodeAt(i)-45;
                var v1= code.substr(x*2,1);
                var v2= code.substr(x*2+1,1);
                sum += (v1==0)?v2*pos++:pos++*v1+v2*pos++;
        }
        return Math.floor(sum/v2) % 10;
}
```
Der Algorithmus zur Bildung der NBN-Prüfziffer im Rahmen des Projektes CARMEN-AP4 „Persistent Identifier and Metadata Management in Science“ stammt von 2001. Inzwischen sind Prüfziffern nicht mehr notwendig. 

Das Verfahren ist hier sehr gut beschrieben: [http://www.pruefziffernberechnung.de/U/URN.shtml](http://www.pruefziffernberechnung.de/U/URN.shtml):

```


Umsetzungstabelle Buchstaben und Zahlen nach Zahlen (festgelegt)

0 -> 1
1 -> 2
2 -> 3
3 -> 4
4 -> 5
5 -> 6
6 -> 7
7 -> 8
8 -> 9
9 -> 4,1
	
A -> 1,8
B -> 1,4
C -> 1,9
D -> 1,5
E -> 1,6
F -> 2,1
G -> 2,2
H -> 2,3
I -> 2,4
J -> 2,5
	
K -> 4,2
L -> 2,6
M -> 2,7
N -> 1,3
O -> 2,8
P -> 2,9
Q -> 3,1
R -> 1,2
S -> 3,2
T -> 3,3
	
U -> 1,1
V -> 3,4
W -> 3,5
X -> 3,6
Y -> 3,7
Z -> 3,8
- -> 3,9
: -> 1,7

_ -> 4,3 (neu: BSZ)
/ -> 4,5 (neu: Projekt STD)
. -> 4,7 (neu: Projekt STD)
+ -> 4,9 (neu: Projekt STD)


Nach der Zeichensubstitution kann die Prüfziffer errechnet werden.

    Alle Ziffern werden von links nach rechts, beginnend mit der ersten Ziffer, mit ihrer Position in der Ziffernfolge gewichtet.
    Die Produkte werden summiert.
    Die Produktsumme wird durch die letzte Stelle des URN dividiert.
    Die Einerstelle des Quotienten ist die Prüfziffer.

Der Algorithmus von mir setzt auf die ASCII-Reihenfolge und somit auf eine Verweis-auf-Verweis Auflösung:


ASCII Zeichen : -  .  /  0  1  2  3  4  5  6  7  8  9  : [ Toter Bereich ]  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z              _
ASCII Wert Dez:45 46 47 48 49 50 51 52 53 54 55 56 57 58                   65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90             95
URN Value     :39 47 45 01 02 03 04 05 06 07 08 09 41 17 ## ## ## ## ## ## 18 14 19 15 16 21 22 23 24 25 42 26 27 13 28 29 31 12 32 33 11 34 35 36 37 38 ## ## ## ## 43
Array Pos     : 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50  (Char-Wert - 45)
	
Beispiel: urn:nbn:de:0183-mbi0003721 - hierbei ist die Prüfziffer 1
        
U -> 1,1 ->> 1 *  1 =  1 (Der 2. Multiplikator ist die Gewichtung, die hochgezählt wird)
             1 *  2 =  2
R -> 1,2 ->> 1 *  3 =  3
             2 *  4 =  8
N -> 1,3 ->> 1 *  5 =  5
             3 *  6 = 18	
[...]
2 ->   3 --> 3 * 29 = 87
                   ------
                    2855

		Zum Ende die Summe durch 3 teilen (letzte Wert) und hiervon die Einerstelle verwenden. 	
		
		2855 / 3 = 951.6 --> (951.6 mod 10) = 1
		
		
```
