# The Doc #
```
<?xml version="1.0" encoding="utf-8"?>
<sql>
  <datatypes db="sqlite">
    <group label="Affinity">
      <type label="Text" default="" length="1" sql="TEXT" quote="'"
      color="rgb(255,200,200)" />
      <type label="Numeric" default="0" length="0" sql="NUMERIC"
      quote="" color="rgb(238,238,170)" />
      <type label="Integer" default="0" length="0" sql="INTEGER"
      quote="" color="rgb(238,238,170)" />
      <type label="Real" default="0" length="0" sql="REAL" quote=""
      color="rgb(238,238,170)" />
      <type label="None" default="" length="0" sql="NONE" quote=""
      color="rgb(200,255,200)" />
    </group>
  </datatypes>
  <table x="58" y="69" name="Transaction">
    <row name="id" null="0" autoincrement="1">
      <datatype>INTEGER</datatype>
    </row>
    <row name="timestamp" null="0" autoincrement="0">
      <datatype>NUMERIC</datatype>
    </row>
    <row name="user" null="0" autoincrement="0">
      <datatype>TEXT(30)</datatype>
    </row>
    <key type="PRIMARY" name="">
      <part>id</part>
    </key>
  </table>
  <table x="258" y="137" name="transChildren">
    <row name="id" null="0" autoincrement="0">
      <datatype>INTEGER</datatype>
    </row>
    <row name="quantity" null="0" autoincrement="0">
      <datatype>INTEGER</datatype>
    </row>
    <row name="id_Transaction" null="0" autoincrement="0">
      <datatype>INTEGER</datatype>
      <relation table="Transaction" row="id" />
    </row>
    <row name="id_transType" null="0" autoincrement="0">
      <datatype>INTEGER</datatype>
      <relation table="transType" row="id" />
    </row>
    <row name="id_sku" null="0" autoincrement="0">
      <datatype>INTEGER</datatype>
      <relation table="sku" row="id" />
    </row>
    <key type="PRIMARY" name="">
      <part>id</part>
    </key>
  </table>
  <table x="100" y="308" name="transType">
    <row name="id" null="0" autoincrement="1">
      <datatype>INTEGER</datatype>
    </row>
    <row name="description" null="0" autoincrement="0">
      <datatype>TEXT(30)</datatype>
    </row>
    <key type="PRIMARY" name="">
      <part>id</part>
    </key>
  </table>
  <table x="795" y="196" name="items">
    <row name="id" null="0" autoincrement="1">
      <datatype>INTEGER</datatype>
    </row>
    <row name="name" null="0" autoincrement="0">
      <datatype>TEXT</datatype>
    </row>
    <row name="description" null="0" autoincrement="0">
      <datatype>TEXT</datatype>
    </row>
    <key type="PRIMARY" name="">
      <part>id</part>
    </key>
  </table>
  <table x="429" y="315" name="Inventory">
    <row name="id" null="0" autoincrement="1">
      <datatype>INTEGER</datatype>
    </row>
    <row name="location" null="0" autoincrement="0">
      <datatype>TEXT</datatype>
    </row>
    <row name="quantity" null="0" autoincrement="0">
      <datatype>INTEGER</datatype>
    </row>
    <key type="PRIMARY" name="">
      <part>id</part>
    </key>
  </table>
  <table x="790" y="338" name="skuType">
    <row name="id" null="0" autoincrement="1">
      <datatype>INTEGER</datatype>
    </row>
    <row name="description" null="0" autoincrement="0">
      <datatype>TEXT</datatype>
    </row>
    <key type="PRIMARY" name="">
      <part>id</part>
    </key>
  </table>
  <table x="610" y="104" name="sku">
    <row name="id" null="0" autoincrement="1">
      <datatype>INTEGER</datatype>
    </row>
    <row name="cost/price" null="0" autoincrement="0">
      <datatype>INTEGER</datatype>
    </row>
    <row name="id_items" null="0" autoincrement="0">
      <datatype>INTEGER</datatype>
      <relation table="items" row="id" />
    </row>
    <row name="id_skuType" null="0" autoincrement="0">
      <datatype>INTEGER</datatype>
      <relation table="skuType" row="id" />
    </row>
    <row name="id_Inventory" null="0" autoincrement="0">
      <datatype>INTEGER</datatype>
      <relation table="Inventory" row="id" />
    </row>
    <key type="PRIMARY" name="">
      <part>id</part>
    </key>
  </table>
</sql>
```