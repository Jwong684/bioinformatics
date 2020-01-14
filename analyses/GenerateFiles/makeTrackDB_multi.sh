#start
cd /home/jawong/jawong_browsers/DKO_hmedip/mm10/
mark=hmedip

#### 2,133,138 R132H
#### 140,30,43 TET2KO
#### 33,64,95 TET3KO
#### 94,74,110 DKO

for i in 1;
do
echo "track $mark"
echo "compositeTrack on"
echo "shortLabel $mark"
echo "longLabel $mark"
echo "type bigWig"
echo ""

for f in *R132H*bw;
do
echo $f | tr -s '_' '\t' | awk '{print "        " " track", $1"_"$2"_"$3"_"$4}' #change the naming of labels for your sample
echo $f | tr -s '_' '\t' | awk '{print "        " " shortLabel", $1"_"$2"_"$3}' #change the naming of labels for your sample
echo $f | tr -s '_' '\t' | awk '{print "        " " longLabel", $1"_"$2"_"$3"_"$4}' #change the naming of labels for your sample~@~K
echo "        " "parent $mark on"
echo "        " "type bigWig"
echo "        " "visibility full"
echo "        " "maxHeightPixels 70:70:32"
echo "        " "configurable on"
echo "        " "autoScale on"
echo "        " "alwaysZero on"
echo "        " "priority 0.1"
echo "        " "bigDataUrl $f"
echo "        " "color 2,133,138"
echo "        " ""
done

for f in *TET2KO*bw;
do
echo $f | tr -s '_' '\t' | awk '{print "        " " track", $1"_"$2"_"$3"_"$4}' #change the naming of labels for your sample
echo $f | tr -s '_' '\t' | awk '{print "        " " shortLabel", $1"_"$2"_"$3}' #change the naming of labels for your sample
echo $f | tr -s '_' '\t' | awk '{print "        " " longLabel", $1"_"$2"_"$3"_"$4}' #change the naming of labels for your sample~@~K
echo "        " "parent $mark on"
echo "        " "type bigWig"
echo "        " "visibility full"
echo "        " "maxHeightPixels 70:70:32"
echo "        " "configurable on"
echo "        " "autoScale on"
echo "        " "alwaysZero on"
echo "        " "priority 0.1"
echo "        " "bigDataUrl $f"
echo "        " "color 140,30,43"
echo "        " ""
done
#### 140,30,43 TET2KO
#### 33,64,95 TET3KO
#### 94,74,110 DKO
for f in *TET3KO*bw;
do
echo $f | tr -s '_' '\t' | awk '{print "        " " track", $1"_"$2"_"$3"_"$4}' #change the naming of labels for your sample
echo $f | tr -s '_' '\t' | awk '{print "        " " shortLabel", $1"_"$2"_"$3}' #change the naming of labels for your sample
echo $f | tr -s '_' '\t' | awk '{print "        " " longLabel", $1"_"$2"_"$3"_"$4}' #change the naming of labels for your sample~@~K
echo "        " "parent $mark on"
echo "        " "type bigWig"
echo "        " "visibility full"
echo "        " "maxHeightPixels 70:70:32"
echo "        " "configurable on"
echo "        " "autoScale on"
echo "        " "alwaysZero on"
echo "        " "priority 0.1"
echo "        " "bigDataUrl $f"
echo "        " "color 33,64,95"
echo "        " ""
done

for f in *DKO*bw;
do
echo $f | tr -s '_' '\t' | awk '{print "        " " track", $1"_"$2"_"$3"_"$4}' #change the naming of labels for your sample
echo $f | tr -s '_' '\t' | awk '{print "        " " shortLabel", $1"_"$2"_"$3}' #change the naming of labels for your sample
echo $f | tr -s '_' '\t' | awk '{print "        " " longLabel", $1"_"$2"_"$3"_"$4}' #change the naming of labels for your sample~@~K
echo "        " "parent $mark on"
echo "        " "type bigWig"
echo "        " "visibility full"
echo "        " "maxHeightPixels 70:70:32"
echo "        " "configurable on"
echo "        " "autoScale on"
echo "        " "alwaysZero on"
echo "        " "priority 0.1"
echo "        " "bigDataUrl $f"
echo "        " "color 94,74,110"
echo "        " ""
done
done >trackDb.txt
#end