<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.6.2">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="2" name="Route2" color="1" fill="3" visible="no" active="no"/>
<layer number="3" name="Route3" color="4" fill="3" visible="no" active="no"/>
<layer number="4" name="Route4" color="1" fill="4" visible="no" active="no"/>
<layer number="5" name="Route5" color="4" fill="4" visible="no" active="no"/>
<layer number="6" name="Route6" color="1" fill="8" visible="no" active="no"/>
<layer number="7" name="Route7" color="4" fill="8" visible="no" active="no"/>
<layer number="8" name="Route8" color="1" fill="2" visible="no" active="no"/>
<layer number="9" name="Route9" color="4" fill="2" visible="no" active="no"/>
<layer number="10" name="Route10" color="1" fill="7" visible="no" active="no"/>
<layer number="11" name="Route11" color="4" fill="7" visible="no" active="no"/>
<layer number="12" name="Route12" color="1" fill="5" visible="no" active="no"/>
<layer number="13" name="Route13" color="4" fill="5" visible="no" active="no"/>
<layer number="14" name="Route14" color="1" fill="6" visible="no" active="no"/>
<layer number="15" name="Route15" color="4" fill="6" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="88" name="SimResults" color="9" fill="1" visible="yes" active="yes"/>
<layer number="89" name="SimProbes" color="9" fill="1" visible="yes" active="yes"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S" xrefpart="/%S">
<libraries>
<library name="frames" urn="urn:adsk.eagle:library:229">
<description>&lt;b&gt;Frames for Sheet and Layout&lt;/b&gt;</description>
<packages>
</packages>
<symbols>
<symbol name="A4L-LOC" urn="urn:adsk.eagle:symbol:13874/1" library_version="1">
<wire x1="256.54" y1="3.81" x2="256.54" y2="8.89" width="0.1016" layer="94"/>
<wire x1="256.54" y1="8.89" x2="256.54" y2="13.97" width="0.1016" layer="94"/>
<wire x1="256.54" y1="13.97" x2="256.54" y2="19.05" width="0.1016" layer="94"/>
<wire x1="256.54" y1="19.05" x2="256.54" y2="24.13" width="0.1016" layer="94"/>
<wire x1="161.29" y1="3.81" x2="161.29" y2="24.13" width="0.1016" layer="94"/>
<wire x1="161.29" y1="24.13" x2="215.265" y2="24.13" width="0.1016" layer="94"/>
<wire x1="215.265" y1="24.13" x2="256.54" y2="24.13" width="0.1016" layer="94"/>
<wire x1="246.38" y1="3.81" x2="246.38" y2="8.89" width="0.1016" layer="94"/>
<wire x1="246.38" y1="8.89" x2="256.54" y2="8.89" width="0.1016" layer="94"/>
<wire x1="246.38" y1="8.89" x2="215.265" y2="8.89" width="0.1016" layer="94"/>
<wire x1="215.265" y1="8.89" x2="215.265" y2="3.81" width="0.1016" layer="94"/>
<wire x1="215.265" y1="8.89" x2="215.265" y2="13.97" width="0.1016" layer="94"/>
<wire x1="215.265" y1="13.97" x2="256.54" y2="13.97" width="0.1016" layer="94"/>
<wire x1="215.265" y1="13.97" x2="215.265" y2="19.05" width="0.1016" layer="94"/>
<wire x1="215.265" y1="19.05" x2="256.54" y2="19.05" width="0.1016" layer="94"/>
<wire x1="215.265" y1="19.05" x2="215.265" y2="24.13" width="0.1016" layer="94"/>
<text x="217.17" y="15.24" size="2.54" layer="94">&gt;DRAWING_NAME</text>
<text x="217.17" y="10.16" size="2.286" layer="94">&gt;LAST_DATE_TIME</text>
<text x="230.505" y="5.08" size="2.54" layer="94">&gt;SHEET</text>
<text x="216.916" y="4.953" size="2.54" layer="94">Sheet:</text>
<frame x1="0" y1="0" x2="260.35" y2="179.07" columns="6" rows="4" layer="94"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="A4L-LOC" urn="urn:adsk.eagle:component:13926/1" prefix="FRAME" uservalue="yes" library_version="1">
<description>&lt;b&gt;FRAME&lt;/b&gt;&lt;p&gt;
DIN A4, landscape with location and doc. field</description>
<gates>
<gate name="G$1" symbol="A4L-LOC" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="XT30UPB-M">
<packages>
<package name="XT30UPB-M">
<wire x1="-5.989" y1="2.6" x2="-5.989" y2="-2.6" width="0.127" layer="21"/>
<wire x1="-5.989" y1="-2.6" x2="4.699" y2="-2.6" width="0.127" layer="21"/>
<wire x1="4.699" y1="-2.6" x2="6.116" y2="-1.397" width="0.127" layer="21"/>
<wire x1="6.116" y1="-1.397" x2="6.116" y2="1.143" width="0.127" layer="21"/>
<wire x1="6.116" y1="1.143" x2="4.699" y2="2.6" width="0.127" layer="21"/>
<wire x1="4.699" y1="2.6" x2="-5.989" y2="2.6" width="0.127" layer="21"/>
<wire x1="-5.08" y1="0.35" x2="-5.08" y2="-0.35" width="0.127" layer="21"/>
<wire x1="-5.435" y1="0" x2="-4.735" y2="0" width="0.127" layer="21"/>
<wire x1="4.699" y1="0" x2="5.334" y2="0" width="0.127" layer="21"/>
<pad name="P$1" x="-2.5" y="0" drill="2.794"/>
<pad name="P$2" x="2.5" y="0" drill="2.794"/>
</package>
</packages>
<symbols>
<symbol name="CONN_02">
<description>&lt;h3&gt;2 Pin Connection&lt;/h3&gt;</description>
<wire x1="3.81" y1="-2.54" x2="-2.54" y2="-2.54" width="0.4064" layer="94"/>
<wire x1="1.27" y1="2.54" x2="2.54" y2="2.54" width="0.6096" layer="94"/>
<wire x1="1.27" y1="0" x2="2.54" y2="0" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="5.08" x2="-2.54" y2="-2.54" width="0.4064" layer="94"/>
<wire x1="3.81" y1="-2.54" x2="3.81" y2="5.08" width="0.4064" layer="94"/>
<wire x1="-2.54" y1="5.08" x2="3.81" y2="5.08" width="0.4064" layer="94"/>
<text x="-2.54" y="-4.826" size="1.778" layer="96">&gt;VALUE</text>
<text x="-2.54" y="5.588" size="1.778" layer="95">&gt;NAME</text>
<pin name="-" x="7.62" y="0" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="+" x="7.62" y="2.54" length="middle" direction="pas" swaplevel="1" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="XT30UPB-M">
<description> &lt;a href="https://pricing.snapeda.com/parts/XT30UPB-M/amass/view-part?ref=eda"&gt;Check availability&lt;/a&gt;</description>
<gates>
<gate name="G$1" symbol="CONN_02" x="2.54" y="2.54"/>
</gates>
<devices>
<device name="" package="XT30UPB-M">
<connects>
<connect gate="G$1" pin="+" pad="P$1"/>
<connect gate="G$1" pin="-" pad="P$2"/>
</connects>
<technologies>
<technology name="">
<attribute name="AVAILABILITY" value="Not in stock"/>
<attribute name="CHECK_PRICES" value="https://www.snapeda.com/parts/XT30UPB-M/AMASS/view-part/?ref=eda"/>
<attribute name="DESCRIPTION" value=" Socket; DC supply; XT30; male; PIN: 2; on PCBs; THT; yellow; 15A; 500V "/>
<attribute name="MF" value="amass"/>
<attribute name="MP" value="XT30UPB-M"/>
<attribute name="PACKAGE" value="None"/>
<attribute name="PRICE" value="None"/>
<attribute name="SNAPEDA_LINK" value="https://www.snapeda.com/parts/XT30UPB-M/AMASS/view-part/?ref=snap"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="B2B-XH-A_LF__SN_">
<packages>
<package name="JST_B2B-XH-A(LF)(SN)">
<wire x1="3.7" y1="2.875" x2="3.7" y2="-2.875" width="0.127" layer="51"/>
<wire x1="3.7" y1="-2.875" x2="-3.7" y2="-2.875" width="0.127" layer="51"/>
<wire x1="-3.7" y1="-2.875" x2="-3.7" y2="2.875" width="0.127" layer="51"/>
<wire x1="-3.7" y1="2.875" x2="3.7" y2="2.875" width="0.127" layer="51"/>
<circle x="4.44" y="-0.525" radius="0.1" width="0.2" layer="51"/>
<wire x1="3.7" y1="2.875" x2="3.7" y2="-2.875" width="0.127" layer="21"/>
<wire x1="3.7" y1="-2.875" x2="-3.7" y2="-2.875" width="0.127" layer="21"/>
<wire x1="-3.7" y1="-2.875" x2="-3.7" y2="2.875" width="0.127" layer="21"/>
<wire x1="-3.7" y1="2.875" x2="3.7" y2="2.875" width="0.127" layer="21"/>
<wire x1="-3.95" y1="3.125" x2="-3.95" y2="-3.125" width="0.05" layer="39"/>
<wire x1="-3.95" y1="-3.125" x2="3.95" y2="-3.125" width="0.05" layer="39"/>
<wire x1="3.95" y1="-3.125" x2="3.95" y2="3.125" width="0.05" layer="39"/>
<wire x1="3.95" y1="3.125" x2="-3.95" y2="3.125" width="0.05" layer="39"/>
<circle x="4.44" y="-0.525" radius="0.1" width="0.2" layer="21"/>
<text x="-3.95" y="4.125" size="1.27" layer="25">&gt;NAME</text>
<text x="-3.95" y="-4.125" size="1.27" layer="27" align="top-left">&gt;VALUE</text>
<pad name="2" x="-1.25" y="-0.525" drill="1.05"/>
<pad name="1" x="1.25" y="-0.525" drill="1.05" shape="square"/>
</package>
</packages>
<symbols>
<symbol name="B2B-XH-A(LF)(SN)">
<wire x1="-3.81" y1="3.81" x2="-2.54" y2="5.08" width="0.254" layer="94"/>
<wire x1="-3.81" y1="3.81" x2="-3.81" y2="-1.27" width="0.254" layer="94"/>
<wire x1="-3.81" y1="-1.27" x2="-2.54" y2="-2.54" width="0.254" layer="94"/>
<wire x1="-2.54" y1="-2.54" x2="3.81" y2="-2.54" width="0.254" layer="94"/>
<wire x1="3.81" y1="-2.54" x2="3.81" y2="5.08" width="0.254" layer="94"/>
<wire x1="3.81" y1="5.08" x2="-2.54" y2="5.08" width="0.254" layer="94"/>
<text x="-2.54" y="6.35" size="1.778" layer="95">&gt;NAME</text>
<text x="-2.54" y="-5.08" size="1.778" layer="96">&gt;VALUE</text>
<rectangle x1="-3.175" y1="2.2225" x2="-1.5875" y2="2.8575" layer="94"/>
<rectangle x1="-3.175" y1="-0.3175" x2="-1.5875" y2="0.3175" layer="94"/>
<pin name="1" x="-7.62" y="2.54" length="middle" direction="pas"/>
<pin name="2" x="-7.62" y="0" length="middle" direction="pas"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="B2B-XH-A(LF)(SN)" prefix="J">
<description> &lt;a href="https://pricing.snapeda.com/parts/B2B-XH-A%28LF%29%28SN%29/JST%20Sales%20America%20Inc./view-part?ref=eda"&gt;Check availability&lt;/a&gt;</description>
<gates>
<gate name="G$1" symbol="B2B-XH-A(LF)(SN)" x="0" y="0"/>
</gates>
<devices>
<device name="" package="JST_B2B-XH-A(LF)(SN)">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name="">
<attribute name="AVAILABILITY" value="In Stock"/>
<attribute name="CHECK_PRICES" value="https://www.snapeda.com/parts/B2B-XH-A(LF)(SN)/JST+Sales+America+Inc./view-part/?ref=eda"/>
<attribute name="DESCRIPTION" value=" Connector Header Through Hole 2 position 0.098 (2.50mm) "/>
<attribute name="MF" value="JST Sales America Inc."/>
<attribute name="MP" value="B2B-XH-A(LF)(SN)"/>
<attribute name="PACKAGE" value="None"/>
<attribute name="PRICE" value="None"/>
<attribute name="SNAPEDA_LINK" value="https://www.snapeda.com/parts/B2B-XH-A(LF)(SN)/JST+Sales+America+Inc./view-part/?ref=snap"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="B6B-XH-A_LF__SN_">
<packages>
<package name="JST_B6B-XH-A(LF)(SN)">
<wire x1="-8.7" y1="2.875" x2="8.7" y2="2.875" width="0.127" layer="21"/>
<wire x1="8.7" y1="2.875" x2="8.7" y2="-2.875" width="0.127" layer="21"/>
<wire x1="8.7" y1="-2.875" x2="-8.7" y2="-2.875" width="0.127" layer="21"/>
<wire x1="-8.7" y1="-2.875" x2="-8.7" y2="2.875" width="0.127" layer="21"/>
<wire x1="-8.7" y1="2.875" x2="8.7" y2="2.875" width="0.127" layer="51"/>
<wire x1="8.7" y1="2.875" x2="8.7" y2="-2.875" width="0.127" layer="51"/>
<wire x1="8.7" y1="-2.875" x2="-8.7" y2="-2.875" width="0.127" layer="51"/>
<wire x1="-8.7" y1="-2.875" x2="-8.7" y2="2.875" width="0.127" layer="51"/>
<wire x1="-8.95" y1="3.125" x2="8.95" y2="3.125" width="0.05" layer="39"/>
<wire x1="8.95" y1="3.125" x2="8.95" y2="-3.125" width="0.05" layer="39"/>
<wire x1="8.95" y1="-3.125" x2="-8.95" y2="-3.125" width="0.05" layer="39"/>
<wire x1="-8.95" y1="-3.125" x2="-8.95" y2="3.125" width="0.05" layer="39"/>
<text x="-8.95" y="4" size="1.2" layer="25" ratio="18">&gt;NAME</text>
<text x="-8.95" y="-5" size="1.2" layer="27" ratio="18">&gt;VALUE</text>
<circle x="9.5" y="-0.525" radius="0.1" width="0.2" layer="21"/>
<circle x="9.5" y="-0.525" radius="0.1" width="0.2" layer="51"/>
<pad name="3" x="1.25" y="-0.525" drill="1"/>
<pad name="4" x="-1.25" y="-0.525" drill="1"/>
<pad name="2" x="3.75" y="-0.525" drill="1"/>
<pad name="1" x="6.25" y="-0.525" drill="1" shape="square"/>
<pad name="5" x="-3.75" y="-0.525" drill="1"/>
<pad name="6" x="-6.25" y="-0.525" drill="1"/>
</package>
</packages>
<symbols>
<symbol name="B6B-XH-A(LF)(SN)">
<wire x1="-3.81" y1="6.35" x2="-2.54" y2="7.62" width="0.254" layer="94"/>
<wire x1="-3.81" y1="6.35" x2="-3.81" y2="-8.89" width="0.254" layer="94"/>
<wire x1="-3.81" y1="-8.89" x2="-2.54" y2="-10.16" width="0.254" layer="94"/>
<wire x1="-2.54" y1="-10.16" x2="3.81" y2="-10.16" width="0.254" layer="94"/>
<wire x1="3.81" y1="-10.16" x2="3.81" y2="7.62" width="0.254" layer="94"/>
<wire x1="3.81" y1="7.62" x2="-2.54" y2="7.62" width="0.254" layer="94"/>
<text x="-2.54" y="8.89" size="1.778" layer="95">&gt;NAME</text>
<text x="-2.54" y="-12.7" size="1.778" layer="96">&gt;VALUE</text>
<rectangle x1="-3.175" y1="4.7625" x2="-1.5875" y2="5.3975" layer="94"/>
<rectangle x1="-3.175" y1="2.2225" x2="-1.5875" y2="2.8575" layer="94"/>
<rectangle x1="-3.175" y1="-0.3175" x2="-1.5875" y2="0.3175" layer="94"/>
<rectangle x1="-3.175" y1="-2.8575" x2="-1.5875" y2="-2.2225" layer="94"/>
<rectangle x1="-3.175" y1="-5.3975" x2="-1.5875" y2="-4.7625" layer="94"/>
<rectangle x1="-3.175" y1="-7.9375" x2="-1.5875" y2="-7.3025" layer="94"/>
<pin name="1" x="-7.62" y="5.08" length="middle" direction="pas"/>
<pin name="2" x="-7.62" y="2.54" length="middle" direction="pas"/>
<pin name="3" x="-7.62" y="0" length="middle" direction="pas"/>
<pin name="4" x="-7.62" y="-2.54" length="middle" direction="pas"/>
<pin name="5" x="-7.62" y="-5.08" length="middle" direction="pas"/>
<pin name="6" x="-7.62" y="-7.62" length="middle" direction="pas"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="B6B-XH-A(LF)(SN)" prefix="J">
<description> &lt;a href="https://pricing.snapeda.com/parts/B6B-XH-A%28LF%29%28SN%29/JST%20Sales/view-part?ref=eda"&gt;Check availability&lt;/a&gt;</description>
<gates>
<gate name="G$1" symbol="B6B-XH-A(LF)(SN)" x="0" y="0"/>
</gates>
<devices>
<device name="" package="JST_B6B-XH-A(LF)(SN)">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
<connect gate="G$1" pin="3" pad="3"/>
<connect gate="G$1" pin="4" pad="4"/>
<connect gate="G$1" pin="5" pad="5"/>
<connect gate="G$1" pin="6" pad="6"/>
</connects>
<technologies>
<technology name="">
<attribute name="AVAILABILITY" value="In Stock"/>
<attribute name="CHECK_PRICES" value="https://www.snapeda.com/parts/B6B-XH-A(LF)(SN)/JST+Sales+America+Inc./view-part/?ref=eda"/>
<attribute name="DESCRIPTION" value=" Connector Header Through Hole 6 position 0.098 (2.50mm) "/>
<attribute name="MF" value="JST Sales"/>
<attribute name="MP" value="B6B-XH-A(LF)(SN)"/>
<attribute name="PACKAGE" value="None"/>
<attribute name="PRICE" value="None"/>
<attribute name="SNAPEDA_LINK" value="https://www.snapeda.com/parts/B6B-XH-A(LF)(SN)/JST+Sales+America+Inc./view-part/?ref=snap"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="UnderactuatedDorsalFin">
<packages>
<package name="SETSAFE_C1_FUSE">
<pad name="+" x="-6" y="0" drill="1" diameter="3.81"/>
<pad name="-" x="6" y="0" drill="1" diameter="3.81"/>
<wire x1="-3.75" y1="1.25" x2="-3.75" y2="-1.25" width="0.127" layer="21"/>
<wire x1="-3.75" y1="-1.25" x2="3.75" y2="-1.25" width="0.127" layer="21"/>
<wire x1="3.75" y1="-1.25" x2="3.75" y2="1.25" width="0.127" layer="21"/>
<wire x1="3.75" y1="1.25" x2="-3.75" y2="1.25" width="0.127" layer="21"/>
</package>
</packages>
<symbols>
<symbol name="SETSAFE_C1_FUSE">
<pin name="+" x="-2.54" y="-7.62" length="middle" rot="R90"/>
<pin name="-" x="2.54" y="-7.62" length="middle" rot="R90"/>
<wire x1="-7.62" y1="-5.08" x2="-7.62" y2="7.62" width="0.254" layer="94"/>
<wire x1="-7.62" y1="7.62" x2="7.62" y2="7.62" width="0.254" layer="94"/>
<wire x1="7.62" y1="7.62" x2="7.62" y2="-5.08" width="0.254" layer="94"/>
<wire x1="7.62" y1="-5.08" x2="-7.62" y2="-5.08" width="0.254" layer="94"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="SETSAFE_C1_FUSE">
<gates>
<gate name="G$1" symbol="SETSAFE_C1_FUSE" x="0" y="0"/>
</gates>
<devices>
<device name="" package="SETSAFE_C1_FUSE">
<connects>
<connect gate="G$1" pin="+" pad="+"/>
<connect gate="G$1" pin="-" pad="-"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="FRAME1" library="frames" library_urn="urn:adsk.eagle:library:229" deviceset="A4L-LOC" device=""/>
<part name="BATT1_IN" library="XT30UPB-M" deviceset="XT30UPB-M" device=""/>
<part name="BAT2_IN" library="XT30UPB-M" deviceset="XT30UPB-M" device=""/>
<part name="BATT1_CONN_BO" library="B2B-XH-A_LF__SN_" deviceset="B2B-XH-A(LF)(SN)" device=""/>
<part name="BATT2_CONN_BO" library="B2B-XH-A_LF__SN_" deviceset="B2B-XH-A(LF)(SN)" device=""/>
<part name="BATT1_BAL_IN" library="B6B-XH-A_LF__SN_" deviceset="B6B-XH-A(LF)(SN)" device=""/>
<part name="BATT2_BAL_IN" library="B6B-XH-A_LF__SN_" deviceset="B6B-XH-A(LF)(SN)" device=""/>
<part name="BAT1_BALCONN_BO" library="B6B-XH-A_LF__SN_" deviceset="B6B-XH-A(LF)(SN)" device=""/>
<part name="BAT2_BALCONN_BO" library="B6B-XH-A_LF__SN_" deviceset="B6B-XH-A(LF)(SN)" device=""/>
<part name="OUT_HEAD" library="XT30UPB-M" deviceset="XT30UPB-M" device=""/>
<part name="OUT_TAIL" library="XT30UPB-M" deviceset="XT30UPB-M" device=""/>
<part name="FUSE" library="UnderactuatedDorsalFin" deviceset="SETSAFE_C1_FUSE" device=""/>
</parts>
<sheets>
<sheet>
<plain>
<wire x1="20.32" y1="167.64" x2="20.32" y2="121.92" width="0.1524" layer="97"/>
<wire x1="20.32" y1="121.92" x2="60.96" y2="121.92" width="0.1524" layer="97"/>
<wire x1="60.96" y1="121.92" x2="60.96" y2="167.64" width="0.1524" layer="97"/>
<wire x1="60.96" y1="167.64" x2="20.32" y2="167.64" width="0.1524" layer="97"/>
<wire x1="20.32" y1="109.22" x2="20.32" y2="63.5" width="0.1524" layer="97"/>
<wire x1="20.32" y1="63.5" x2="60.96" y2="63.5" width="0.1524" layer="97"/>
<wire x1="60.96" y1="63.5" x2="60.96" y2="109.22" width="0.1524" layer="97"/>
<wire x1="60.96" y1="109.22" x2="20.32" y2="109.22" width="0.1524" layer="97"/>
<text x="33.02" y="170.18" size="1.778" layer="97">BATTERY 1 IN</text>
<text x="33.02" y="111.76" size="1.778" layer="97">BATTERY 2 IN</text>
<wire x1="71.12" y1="167.64" x2="71.12" y2="121.92" width="0.1524" layer="97"/>
<wire x1="71.12" y1="121.92" x2="111.76" y2="121.92" width="0.1524" layer="97"/>
<wire x1="111.76" y1="121.92" x2="111.76" y2="167.64" width="0.1524" layer="97"/>
<wire x1="111.76" y1="167.64" x2="71.12" y2="167.64" width="0.1524" layer="97"/>
<text x="71.12" y="170.18" size="1.778" layer="97">BATTERY 1 CONN BREAKOUT</text>
<wire x1="78.74" y1="109.22" x2="78.74" y2="63.5" width="0.1524" layer="97"/>
<wire x1="78.74" y1="63.5" x2="119.38" y2="63.5" width="0.1524" layer="97"/>
<wire x1="119.38" y1="63.5" x2="119.38" y2="109.22" width="0.1524" layer="97"/>
<wire x1="119.38" y1="109.22" x2="78.74" y2="109.22" width="0.1524" layer="97"/>
<text x="81.28" y="111.76" size="1.778" layer="97">BATTERY 2 CONN BREAKOUT</text>
<wire x1="38.1" y1="55.88" x2="38.1" y2="10.16" width="0.1524" layer="97"/>
<wire x1="38.1" y1="10.16" x2="96.52" y2="10.16" width="0.1524" layer="97"/>
<wire x1="96.52" y1="10.16" x2="96.52" y2="55.88" width="0.1524" layer="97"/>
<wire x1="96.52" y1="55.88" x2="38.1" y2="55.88" width="0.1524" layer="97"/>
<text x="63.5" y="58.42" size="1.778" layer="97">POWER OUT</text>
</plain>
<instances>
<instance part="FRAME1" gate="G$1" x="0" y="0" smashed="yes">
<attribute name="DRAWING_NAME" x="217.17" y="15.24" size="2.54" layer="94"/>
<attribute name="LAST_DATE_TIME" x="217.17" y="10.16" size="2.286" layer="94"/>
<attribute name="SHEET" x="230.505" y="5.08" size="2.54" layer="94"/>
</instance>
<instance part="BATT1_IN" gate="G$1" x="33.02" y="157.48" smashed="yes">
<attribute name="VALUE" x="30.48" y="152.654" size="1.778" layer="96"/>
<attribute name="NAME" x="30.48" y="163.068" size="1.778" layer="95"/>
</instance>
<instance part="BAT2_IN" gate="G$1" x="35.56" y="99.06" smashed="yes">
<attribute name="VALUE" x="33.02" y="94.234" size="1.778" layer="96"/>
<attribute name="NAME" x="33.02" y="104.648" size="1.778" layer="95"/>
</instance>
<instance part="BATT1_CONN_BO" gate="G$1" x="81.28" y="157.48" smashed="yes">
<attribute name="NAME" x="78.74" y="163.83" size="1.778" layer="95"/>
<attribute name="VALUE" x="78.74" y="152.4" size="1.778" layer="96"/>
</instance>
<instance part="BATT2_CONN_BO" gate="G$1" x="88.9" y="99.06" smashed="yes">
<attribute name="NAME" x="86.36" y="105.41" size="1.778" layer="95"/>
<attribute name="VALUE" x="86.36" y="93.98" size="1.778" layer="96"/>
</instance>
<instance part="BATT1_BAL_IN" gate="G$1" x="43.18" y="137.16" smashed="yes" rot="R180">
<attribute name="NAME" x="45.72" y="128.27" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="45.72" y="149.86" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="BATT2_BAL_IN" gate="G$1" x="50.8" y="78.74" smashed="yes" rot="R180">
<attribute name="NAME" x="53.34" y="69.85" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="53.34" y="91.44" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="BAT1_BALCONN_BO" gate="G$1" x="81.28" y="137.16" smashed="yes" rot="MR180">
<attribute name="NAME" x="78.74" y="128.27" size="1.778" layer="95" rot="MR180"/>
<attribute name="VALUE" x="78.74" y="149.86" size="1.778" layer="96" rot="MR180"/>
</instance>
<instance part="BAT2_BALCONN_BO" gate="G$1" x="91.44" y="78.74" smashed="yes" rot="MR180">
<attribute name="NAME" x="88.9" y="69.85" size="1.778" layer="95" rot="MR180"/>
<attribute name="VALUE" x="88.9" y="91.44" size="1.778" layer="96" rot="MR180"/>
</instance>
<instance part="OUT_HEAD" gate="G$1" x="71.12" y="43.18" smashed="yes">
<attribute name="VALUE" x="68.58" y="38.354" size="1.778" layer="96"/>
<attribute name="NAME" x="68.58" y="48.768" size="1.778" layer="95"/>
</instance>
<instance part="OUT_TAIL" gate="G$1" x="71.12" y="25.4" smashed="yes">
<attribute name="VALUE" x="68.58" y="20.574" size="1.778" layer="96"/>
<attribute name="NAME" x="68.58" y="30.988" size="1.778" layer="95"/>
</instance>
<instance part="FUSE" gate="G$1" x="55.88" y="45.72" smashed="yes" rot="R270"/>
</instances>
<busses>
</busses>
<nets>
<net name="BATT_MID" class="0">
<segment>
<pinref part="BATT1_IN" gate="G$1" pin="+"/>
<pinref part="BATT1_CONN_BO" gate="G$1" pin="1"/>
<wire x1="40.64" y1="160.02" x2="73.66" y2="160.02" width="0.1524" layer="91"/>
<label x="55.88" y="160.02" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="BAT2_IN" gate="G$1" pin="-"/>
<pinref part="BATT2_CONN_BO" gate="G$1" pin="2"/>
<wire x1="43.18" y1="99.06" x2="81.28" y2="99.06" width="0.1524" layer="91"/>
<label x="60.96" y="99.06" size="1.778" layer="95"/>
</segment>
</net>
<net name="GND" class="0">
<segment>
<pinref part="OUT_HEAD" gate="G$1" pin="-"/>
<wire x1="78.74" y1="43.18" x2="88.9" y2="43.18" width="0.1524" layer="91"/>
<label x="86.36" y="43.18" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="OUT_TAIL" gate="G$1" pin="-"/>
<wire x1="78.74" y1="25.4" x2="88.9" y2="25.4" width="0.1524" layer="91"/>
<label x="83.82" y="25.4" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="BATT1_IN" gate="G$1" pin="-"/>
<pinref part="BATT1_CONN_BO" gate="G$1" pin="2"/>
<wire x1="40.64" y1="157.48" x2="73.66" y2="157.48" width="0.1524" layer="91"/>
<label x="53.34" y="157.48" size="1.778" layer="95"/>
</segment>
</net>
<net name="VOUT" class="0">
<segment>
<pinref part="FUSE" gate="G$1" pin="-"/>
<wire x1="48.26" y1="43.18" x2="40.64" y2="43.18" width="0.1524" layer="91"/>
<label x="40.64" y="43.18" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="OUT_HEAD" gate="G$1" pin="+"/>
<wire x1="78.74" y1="45.72" x2="88.9" y2="45.72" width="0.1524" layer="91"/>
<label x="83.82" y="45.72" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="OUT_TAIL" gate="G$1" pin="+"/>
<wire x1="78.74" y1="27.94" x2="88.9" y2="27.94" width="0.1524" layer="91"/>
<label x="83.82" y="27.94" size="1.778" layer="95"/>
</segment>
</net>
<net name="VOUT_PREFUSE" class="0">
<segment>
<wire x1="45.72" y1="101.6" x2="45.72" y2="48.26" width="0.1524" layer="91"/>
<wire x1="45.72" y1="48.26" x2="48.26" y2="48.26" width="0.1524" layer="91"/>
<pinref part="FUSE" gate="G$1" pin="+"/>
<label x="38.1" y="58.42" size="1.778" layer="95"/>
<pinref part="BAT2_IN" gate="G$1" pin="+"/>
<pinref part="BATT2_CONN_BO" gate="G$1" pin="1"/>
<wire x1="43.18" y1="101.6" x2="45.72" y2="101.6" width="0.1524" layer="91"/>
<wire x1="45.72" y1="101.6" x2="81.28" y2="101.6" width="0.1524" layer="91"/>
<junction x="45.72" y="101.6"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="BATT1_BAL_IN" gate="G$1" pin="6"/>
<pinref part="BAT1_BALCONN_BO" gate="G$1" pin="6"/>
<wire x1="50.8" y1="144.78" x2="73.66" y2="144.78" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="BATT1_BAL_IN" gate="G$1" pin="5"/>
<pinref part="BAT1_BALCONN_BO" gate="G$1" pin="5"/>
<wire x1="50.8" y1="142.24" x2="73.66" y2="142.24" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="BATT1_BAL_IN" gate="G$1" pin="4"/>
<pinref part="BAT1_BALCONN_BO" gate="G$1" pin="4"/>
<wire x1="50.8" y1="139.7" x2="73.66" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="BATT1_BAL_IN" gate="G$1" pin="3"/>
<pinref part="BAT1_BALCONN_BO" gate="G$1" pin="3"/>
<wire x1="50.8" y1="137.16" x2="73.66" y2="137.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="BATT1_BAL_IN" gate="G$1" pin="2"/>
<pinref part="BAT1_BALCONN_BO" gate="G$1" pin="2"/>
<wire x1="50.8" y1="134.62" x2="73.66" y2="134.62" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="BATT1_BAL_IN" gate="G$1" pin="1"/>
<pinref part="BAT1_BALCONN_BO" gate="G$1" pin="1"/>
<wire x1="50.8" y1="132.08" x2="73.66" y2="132.08" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="BATT2_BAL_IN" gate="G$1" pin="6"/>
<pinref part="BAT2_BALCONN_BO" gate="G$1" pin="6"/>
<wire x1="58.42" y1="86.36" x2="83.82" y2="86.36" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$9" class="0">
<segment>
<pinref part="BATT2_BAL_IN" gate="G$1" pin="5"/>
<pinref part="BAT2_BALCONN_BO" gate="G$1" pin="5"/>
<wire x1="58.42" y1="83.82" x2="83.82" y2="83.82" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<pinref part="BAT2_BALCONN_BO" gate="G$1" pin="4"/>
<pinref part="BATT2_BAL_IN" gate="G$1" pin="4"/>
<wire x1="83.82" y1="81.28" x2="58.42" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<pinref part="BATT2_BAL_IN" gate="G$1" pin="3"/>
<pinref part="BAT2_BALCONN_BO" gate="G$1" pin="3"/>
<wire x1="58.42" y1="78.74" x2="83.82" y2="78.74" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<pinref part="BAT2_BALCONN_BO" gate="G$1" pin="2"/>
<pinref part="BATT2_BAL_IN" gate="G$1" pin="2"/>
<wire x1="83.82" y1="76.2" x2="58.42" y2="76.2" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$13" class="0">
<segment>
<pinref part="BATT2_BAL_IN" gate="G$1" pin="1"/>
<pinref part="BAT2_BALCONN_BO" gate="G$1" pin="1"/>
<wire x1="58.42" y1="73.66" x2="83.82" y2="73.66" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
<compatibility>
<note version="8.2" severity="warning">
Since Version 8.2, EAGLE supports online libraries. The ids
of those online libraries will not be understood (or retained)
with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports URNs for individual library
assets (packages, symbols, and devices). The URNs of those assets
will not be understood (or retained) with this version.
</note>
</compatibility>
</eagle>
