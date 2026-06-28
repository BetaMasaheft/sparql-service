# sparql-service


## Fixes needed for expansion of the TEI files

```xml
<!-- missing of base URL -->
<ref type="mss" corresp="BNFabb66A BNFabb66B">le n.66</ref>

<witness xml:id="D" corresp="https://betamasaheft.eu/RIE185bisand270bis#RIE185bisII1 RIE185bisand270bis#RIE185bisII2 RIE185bisand270bis#RIE185bisII3"><idno>RIÉ 185bis and 270bis</idno></witness>

<t:placeName ref="39303">A(u)xoume</t:placeName>

<repository ref=" INS0529AAC"></repository> 

```

Document `LIT7447AbrTarWA` has no TEI namespace in expanded form.

```xml
<relation name="snap:Group" ref="http://data.snapdrgn.net/ontology/snap#Group" active="https://betamasaheft.eu/ETH2279Konno" passive="https://betamasaheft.eu/ETH1973Oromo"/>

<rdf:Description rdf:about="https://betamasaheft.eu/ETH2279Konno">
    <snap:hasBond rdf:resource="https://betamasaheft.eu/bond/Group-https://betamasaheft.eu/ETH1973Oromo"/>
</rdf:Description>
<rdf:Description rdf:about="https://betamasaheft.eu/bond/Group-https://betamasaheft.eu/ETH1973Oromo">
    <rdf:type rdf:resource="http://data.snapdrgn.net/ontology/snap#Group"/>
    <snap:bond-with rdf:resource="https://betamasaheft.eu/ETH1973Oromo"/>
</rdf:Description>
```

```xml
<relation name="snap:Group" ref="http://data.snapdrgn.net/ontology/snap#Group" active="https://betamasaheft.eu/PRS12016Evangelists" passive="https://betamasaheft.eu/PRS5695John"/>
<relation name="snap:Group" ref="http://data.snapdrgn.net/ontology/snap#Group" active="https://betamasaheft.eu/PRS12016Evangelists" passive="https://betamasaheft.eu/PRS6751Mark"/>
<relation name="snap:Group" ref="http://data.snapdrgn.net/ontology/snap#Group" active="https://betamasaheft.eu/PRS12016Evangelists" passive="https://betamasaheft.eu/PRS6902Matthew"/>
<relation name="snap:Group" ref="http://data.snapdrgn.net/ontology/snap#Group" active="https://betamasaheft.eu/PRS12016Evangelists" passive="https://betamasaheft.eu/PRS6387Luke"/>


<rdf:Description rdf:about="https://betamasaheft.eu/PRS12016Evangelists">
    <snap:hasBond rdf:resource="https://betamasaheft.eu/bond/Group-https://betamasaheft.eu/PRS5695John"/>
</rdf:Description>
<rdf:Description rdf:about="https://betamasaheft.eu/bond/Group-https://betamasaheft.eu/PRS5695John">
    <rdf:type rdf:resource="http://data.snapdrgn.net/ontology/snap#Group"/>
    <snap:bond-with rdf:resource="https://betamasaheft.eu/PRS5695John"/>
</rdf:Description>

<rdf:Description rdf:about="https://betamasaheft.eu/PRS12016Evangelists">
    <snap:hasBond rdf:resource="https://betamasaheft.eu/bond/Group-https://betamasaheft.eu/PRS6751Mark"/>
</rdf:Description>
<rdf:Description rdf:about="https://betamasaheft.eu/bond/Group-https://betamasaheft.eu/PRS6751Mark">
    <rdf:type rdf:resource="http://data.snapdrgn.net/ontology/snap#Group"/>
    <snap:bond-with rdf:resource="https://betamasaheft.eu/PRS6751Mark"/>
</rdf:Description>

<rdf:Description rdf:about="https://betamasaheft.eu/PRS12016Evangelists">
    <snap:hasBond rdf:resource="https://betamasaheft.eu/bond/Group-https://betamasaheft.eu/PRS6902Matthew"/>
</rdf:Description>
<rdf:Description rdf:about="https://betamasaheft.eu/bond/Group-https://betamasaheft.eu/PRS6902Matthew">
    <rdf:type rdf:resource="http://data.snapdrgn.net/ontology/snap#Group"/>
    <snap:bond-with rdf:resource="https://betamasaheft.eu/PRS6902Matthew"/>
</rdf:Description>

<rdf:Description rdf:about="https://betamasaheft.eu/PRS12016Evangelists">
    <snap:hasBond rdf:resource="https://betamasaheft.eu/bond/Group-https://betamasaheft.eu/PRS6387Luke"/>
</rdf:Description>
<rdf:Description rdf:about="https://betamasaheft.eu/bond/Group-https://betamasaheft.eu/PRS6387Luke">
    <rdf:type rdf:resource="http://data.snapdrgn.net/ontology/snap#Group"/>
    <snap:bond-with rdf:resource="https://betamasaheft.eu/PRS6387Luke"/>
</rdf:Description>

```



# Errors found in RDF/XML data

> The file LIT6554SacerPrayers should not be named LIT6554SacrePrayers?


## Files manuscripts/BNFabb152.rdf, manuscripts/IVEf67.rdf
```text
there is text between <rdf:type rdf:resource="https://betamasaheft.eu/ontology/Codex"/> and <dcterms:hasPart rdf:resource="...
```

## File manuscripts/BNFabb217.rdf
```text
converted 
https://betamasaheft.eu/STU0005Dictionnaire#&gt;Haleta
to
https://betamasaheft.eu/STU0005Dictionnaire#Haleta
```

## File manuscripts/BNFabb92.rdf
```text
"BNFabb66A BNFabb66B"
to
<dc:relation rdf:resource="https://betamasaheft.eu/https://betamasaheft.eu/BNFabb66A"/><dc:relation rdf:resource="https://betamasaheft.eu/https://betamasaheft.eu/BNFabb66B"/>
```

## File manuscripts/EMIP00453.rdf, manuscripts/EMIP02368.rdf
```text

There is text "no matching prefix..." between tags...
```

## Files persons/PRS0052IHA.rdf, persons/PRS0092IHA.rdf, persons/PRS0391IHA.rdf
```text
converted
<skos:exactMatch rdf:resource="https://www.wikidata.org/entity/ http://viaf.org/viaf/..."/>
to
<skos:exactMatch rdf:resource="http://viaf.org/viaf/..."/>
```

## Files works/LIT1201Bartos.rdf, works/LIT1234Catena.rdf, works/LIT1395Fethan.rdf, works/LIT1461Gadlah.rdf, works/LIT1925Mashaf.rdf, works/LIT1941Mashaf.rdf, works/LIT2619Zenala.rdf, works/LIT3171Commen.rdf, works/LIT4054Gadl.rdf, works/LIT5064HEpA.rdf, works/LIT5261MiracleConception.rdf, works/LIT5264MiracleNativity.rdf, works/LIT6554SacerPrayers.rdf, works/LIT6568YanagastatKebr.rdf, works/LIT6584RHMahbar.rdf, works/LIT7293MartyrMb.rdf
```text
encoded whitespace within IRIs:
<dc:source rdf:resource="https://www.wikidata.org/entity/al-Raššādī, Muḥammad Rašād " /> etc.
```

## Files persons/PRS0867IHA.rdf, persons/PRS0954IHA.rdf
```text
"https://www.wikidata.org/entity/ //viaf.org/viaf/..."
```

## File persons/PRS11288AnAzMi.rdf
```text
converted
https://betamasaheft.eu/bond/Group-https://betamasaheft.eu/PRS11465Anania
to
https://betamasaheft.eu/PRS11465Anania
```

## File persons/PRS11288AnAzMi.rdf
```text
<rdf:Description
    rdf:about="https://betamasaheft.eu/PRS11464Azaria https://betamasaheft.eu/PRS11465Anania https://betamasaheft.eu/PRS11463Misael">
    <rdf:type rdf:resource="http://data.snapdrgn.net/ontology/snap#Group" />
    <snap:bond-with
        rdf:resource="https://betamasaheft.eu/PRS11464Azaria https://betamasaheft.eu/PRS11465Anania https://betamasaheft.eu/PRS11463Misael" />
</rdf:Description>

to

<rdf:Description
    rdf:about="https://betamasaheft.eu/PRS11464Azaria">
    <rdf:type rdf:resource="http://data.snapdrgn.net/ontology/snap#Group" />
    <snap:bond-with
        rdf:resource="https://betamasaheft.eu/PRS11465Anania" />
    <snap:bond-with
        rdf:resource="https://betamasaheft.eu/PRS11463Misael" />            
</rdf:Description>
<rdf:Description
    rdf:about="https://betamasaheft.eu/PRS11465Anania">
    <rdf:type rdf:resource="http://data.snapdrgn.net/ontology/snap#Group" />
    <snap:bond-with
        rdf:resource="https://betamasaheft.eu/PRS11464Azaria" />
    <snap:bond-with
        rdf:resource="https://betamasaheft.eu/PRS11463Misael" />            
</rdf:Description>
<rdf:Description
    rdf:about="https://betamasaheft.eu/PRS11463Misael">
    <rdf:type rdf:resource="http://data.snapdrgn.net/ontology/snap#Group" />
    <snap:bond-with
        rdf:resource="https://betamasaheft.eu/PRS11464Azaria" />
    <snap:bond-with
        rdf:resource="https://betamasaheft.eu/PRS11465Anania" />            
</rdf:Description>   
```

## File persons/PRS11430Apostles.rdf
```text

"https://betamasaheft.eu/bond/Group-https://betamasaheft.eu/PRS7805Peter" etc.

and

snap:bond-with:
"https://betamasaheft.eu/PRS7805Peter https://betamasaheft.eu/PRS11326Andrew https://betamasaheft.eu/PRS5662James https://betamasaheft.eu/PRS5695John https://betamasaheft.eu/PRS7843Philip https://betamasaheft.eu/PRS2481Bartholo https://betamasaheft.eu/PRS9496Thomas https://betamasaheft.eu/PRS6902Matthew https://betamasaheft.eu/PRS5665James https://betamasaheft.eu/PRS5781JudasTh https://betamasaheft.eu/PRS11431Simon https://betamasaheft.eu/PRS5779JudasI"

```

## File persons/PRS9866Walay.rdf
```text

"https://betamasaheft.eu/bond/SonOf -https://betamasaheft.eu/PRS12307Gedewon"
"http://data.snapdrgn.net/ontology/snap#SonOf "

```

## File works/LIT1295Dersan.rdf
```text
<dcterms:hasPart rdf:resource="LIT1295Dersan/part/divLIT1295DersanYakkatitMiracleMoneyFish12" />

<dcterms:hasPart rdf:resource="LIT1295Dersan/part/divLIT1295DersanMaggabitMiracleApocalypse12" />
and
"LIT1295Dersan/part/divLIT1295DersanSaneCommemorativeEuphemia12"
```

## File works/LIT4336Ledata.rdf
```text
empty language <crm:P102_has_title rdf:resource="https://betamasaheft.eu/LIT4336Ledata/title/t3" xml:lang="" />, <dc:title xml:lang="">
```

## File works/LIT4850pseudotrilingual.rdf
```text
non-conformant IRI "https://betamasaheft.eu/RIE185bisand270bis#RIE185bisII1 RIE185bisand270bis#RIE185bisII2 RIE185bisand270bis#RIE185bisII3"
```


## Resources

* [Linked Open Data Based on La Syntaxe du Codex for Manuscripts in Beta maṣāḥǝft](https://dlib.nyu.edu/awdl/isaw/isaw-papers/20-7/)
