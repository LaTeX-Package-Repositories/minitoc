#! /bin/bash
# bash version of pmk csh script (skips copying backups as sources in git anyway)


echo 'Creating the package... you can sip a cappuccino'
# create the package from minitoc.ins and minitoc.dtx
yes |latex minitoc.ins
cat mtc-add.bib | grep -v '^%%' > addbib;mv addbib mtc-add.bib
# save the log file of this phase
cp minitoc.log minitoc.log1
# create the documentation (DVI): 4 latex runs, with index and biblio
if [ -f minitoc.dtx ]; then
if [ -f minitoc.maf ] ; then
    cat minitoc.maf | xargs -i -t \rm {}
fi

echo 'Creating the english documentation...'
touch minitoc.idx minitoc.ind
pdflatex minitoc.dtx
grep -v  '\\ \[]\|'  minitoc.idx | grep -v '|main}{1}$' | grep -v '\! =\\verb\!\*+\!\\\! +' > minitoc.idx1; mv minitoc.idx1 minitoc.idx
sed -e's/:>/=/' < minitoc.idx > minitoc.idx1; mv minitoc.idx1 minitoc.idx
bibtex minitoc
makeindex -s minitoc.ist -o minitoc.ind minitoc.idx
mv minitoc.ilg minitoc.ilg1
#
pdflatex minitoc.dtx
grep -v  '\\ \[]\|'  minitoc.idx | grep -v '|main}{1}$' | grep -v '\! =\\verb\!\*+\!\\\! +' > minitoc.idx1; mv minitoc.idx1 minitoc.idx
sed -e's/:>/=/' < minitoc.idx > minitoc.idx1; mv minitoc.idx1 minitoc.idx
makeindex -s minitoc.ist -o minitoc.ind minitoc.idx
mv minitoc.ilg minitoc.ilg1
#
pdflatex minitoc.dtx
grep -v  '\\ \[]\|'  minitoc.idx | grep -v '|main}{1}$' | grep -v '\! =\\verb\!\*+\!\\\! +' > minitoc.idx1; mv minitoc.idx1 minitoc.idx
sed -e's/:>/=/' < minitoc.idx > minitoc.idx1; mv minitoc.idx1 minitoc.idx
makeindex -s minitoc.ist -o minitoc.ind minitoc.idx
mv minitoc.ilg minitoc.ilg1
#
pdflatex minitoc.dtx
grep -v  '\\ \[]\|'  minitoc.idx | grep -v '|main}{1}$' | grep -v '\! =\\verb\!\*+\!\\\! +' > minitoc.idx1; mv minitoc.idx1 minitoc.idx
sed -e's/:>/=/' < minitoc.idx > minitoc.idx1; mv minitoc.idx1 minitoc.idx
fi
# french documentation
if [ -f minitoc-fr.dtx ] ; then
if [ -f minitoc-fr.maf ] ; then
   cat minitoc-fr.maf | xargs -i -t \rm {}
fi

echo 'Creating the french documentation...'
touch minitoc-fr.idx minitoc-fr.ind
# create the french documentation (PDF): 4 pdflatex runs, with index and biblio
pdflatex minitoc-fr.dtx
grep -v  '\\ \[]\|'  minitoc-fr.idx | grep -v '|main}{1}$' | grep -v '\! =\\verb\!\*+\!\\\! +' > minitoc-fr.idx1; mv minitoc-fr.idx1 minitoc-fr.idx
sed -e's/:>/=/' < minitoc-fr.idx > minitoc-fr.idx1; mv minitoc-fr.idx1 minitoc-fr.idx
bibtex minitoc-fr
makeindex -s minitoc-fr.ist -o minitoc-fr.ind minitoc-fr.idx
mv minitoc-fr.ilg minitoc-fr.ilg1
#
pdflatex minitoc-fr.dtx
grep -v  '\\ \[]\|'  minitoc-fr.idx | grep -v '|main}{1}$' | grep -v '\! =\\verb\!\*+\!\\\! +' > minitoc-fr.idx1; mv minitoc-fr.idx1 minitoc-fr.idx
sed -e's/:>/=/' < minitoc-fr.idx > minitoc-fr.idx1; mv minitoc-fr.idx1 minitoc-fr.idx
makeindex -s minitoc-fr.ist -o minitoc-fr.ind minitoc-fr.idx
mv minitoc-fr.ilg minitoc-fr.ilg1
#
pdflatex minitoc-fr.dtx
grep -v  '\\ \[]\|'  minitoc-fr.idx | grep -v '|main}{1}$' | grep -v '\! =\\verb\!\*+\!\\\! +' > minitoc-fr.idx1; mv minitoc-fr.idx1 minitoc-fr.idx
sed -e's/:>/=/' < minitoc-fr.idx > minitoc-fr.idx1; mv minitoc-fr.idx1 minitoc-fr.idx
makeindex -s minitoc-fr.ist -o minitoc-fr.ind minitoc-fr.idx
mv minitoc-fr.ilg minitoc-fr.ilg1
#
pdflatex minitoc-fr.dtx
grep -v  '\\ \[]\|'  minitoc-fr.idx | grep -v '|main}{1}$' | grep -v '\! =\\verb\!\*+\!\\\! +' > minitoc-fr.idx1; mv minitoc-fr.idx1 minitoc-fr.idx
sed -e's/:>/=/' < minitoc-fr.idx > minitoc-fr.idx1; mv minitoc-fr.idx1 minitoc-fr.idx
else
  echo 'French is still missing'
fi
# composition examples
#######################
for f in mtc-add mtc-ads
do
    for i in  1 2 3
    do
	pdflatex $f
	bibtex $f
	if [ -e $f.idx ]; then
            makeindex -s gind.ist -o $f.ind $f.idx
	fi
	if [ -e $f.glo ]; then
            makeindex -s gglo.ist -o $f.gls $f.glo
	fi
    done
done
#
for i in 1 2 3
do
    for f in  \
        mtc-2c mtc-2nd mtc-3co  mtc-amm mtc-apx mtc-art mtc-bk mtc-bo mtc-ch0 mtc-cri \
               mtc-fko mtc-fo1 mtc-fo2 mtc-gap mtc-hi1 mtc-hi2 mtc-hia mtc-hir mtc-hop mtc-liv mtc-mem mtc-mm1 \
            mtc-mu mtc-nom mtc-ocf mtc-ofs mtc-sbf mtc-scr mtc-syn mtc-tbi mtc-tlc mtc-tlo mtc-tsf mtc-vti 
    do
	pdflatex $f
    done
   makeindex -s nomencl.ist -o mtc-nom.nls mtc-nom.nlo
done
for f  in mtc-add mtc-ads \
            mtc-2c mtc-2nd mtc-3co  mtc-amm mtc-apx mtc-art mtc-bk mtc-bo mtc-ch0 mtc-cri \
            mtc-fko mtc-fo1 mtc-fo2 mtc-gap mtc-hi1 mtc-hi2 mtc-hia mtc-hir mtc-hop mtc-liv mtc-mem mtc-mm1 \
            mtc-mu mtc-nom mtc-ocf mtc-ofs mtc-sbf mtc-scr mtc-syn mtc-tbi mtc-tlc mtc-tlo mtc-tsf mtc-vti 
          do
 \rm -f `cat $f.maf` $f.aux $f.log $f.toc $f.bbl $f.blg $f.lof $f.lot $f.ind $f.idx $f.ilg $f.ind $f.maf
done
\rm mtc-nom.nlo mtc-nom.nls
#######################
# repartition
echo 'Repartition of files into classes'
set WCL=$PWD/tmp-minitoc

for i in 0 1 2 3 4 5 6 7 8 9 10
	  do
  if [ -e ${WCL}$i ]; then
    \rm -rf ${WCL}$i
  fi
  if [ -d ${WCL}$i ]; then
    \rm -rf ${WCL}$i/*
    rmdir ${WCL}$i
  else
    mkdir -m 755 -p ${WCL}$i
  fi
done
# class 0
echo 'Class 0'
cp minitoc.dtx minitoc.ins minitoc-fr.dtx ${WCL}0
chmod 644 ${WCL}0/*
# class 1
echo 'Class 1'
cp minitoc.sty mtcoff.sty mtcmess.sty mtcpatchmem.sty ${WCL}1
cp *.mld *.mlo ${WCL}1
chmod 644 ${WCL}1/*
# class 2
echo 'Class 2'
cp INSTALL minitoc.l README.md TODO ${WCL}2
chmod 644 ${WCL}2/*
# class 3
echo 'Class 3'
cp mtc-add.bib ${WCL}3
for i in  tex pdf
	   do
   for j in \
      mtc-2c mtc-2nd mtc-3co mtc-add mtc-ads mtc-amm mtc-apx mtc-art mtc-bk mtc-bo mtc-ch0 mtc-cri \
      mtc-fko mtc-fo1 mtc-fo2 mtc-gap mtc-hi1 mtc-hi2 mtc-hia mtc-hir mtc-hop mtc-liv mtc-mem mtc-mm1 \
      mtc-mu mtc-nom mtc-ocf mtc-ofs mtc-sbf mtc-scr mtc-syn mtc-tbi mtc-tlc mtc-tlo mtc-tsf mtc-vti
      do
    cp $j.$i ${WCL}3
   done
done
chmod 644 ${WCL}3/*
# class 4
echo 'Class 4'
cp minitoc.bug minitoc.sum ${WCL}4
chmod 644 ${WCL}4/*
# class 5
echo 'Class 5'
cp minitoc.dtx minitoc.ins minitoc.bib minitoc.ist minitoc.lan en-mtc.bst ${WCL}5
chmod 644 ${WCL}5/*
# class 6
echo 'Class 6'
cp lamed3.png ${WCL}6
chmod 644 ${WCL}6/*
# class 7
echo 'Class 7'
cp minitoc.dtx minitoc-fr.dtx minitoc-fr.bib minitoc-fr.ist minitoc-fr.lan minitoc.pre ${WCL}6
cp franc.sty frbib.sty frnew.sty fr-mtc.bst ${WCL}7
chmod 644 ${WCL}7/*
# class 8
echo 'Class 8'
cp minitoc.pdf ${WCL}8
# cp minitoc.ps ${WCL}8
chmod 644 ${WCL}8/*
# class 9
echo 'Class 9'
cp minitoc-fr.pdf ${WCL}9
# cp minitoc-fr.ps ${WCL}9
chmod 644 ${WCL}9/*
# class 10
echo 'Class 10'
cp pmk imk emk fmk rmk tmk xmk cmk ${WCL}10
chmod 744 ${WCL}10/*
# Cleaning
echo "Cleaning"
if [ -f minitoc.maf ]; then
   cat minitoc.maf | xargs -i -t \rm {}
fi
if [ -f minitoc-fr.maf ]; then
   cat minitoc-fr.maf | xargs -i -t \rm {}
fi
#
echo "Running ./tmk to make .tds.zip ..."
bash ./tmk.sh
