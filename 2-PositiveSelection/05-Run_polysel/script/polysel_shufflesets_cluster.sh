#!/bin/bash

#-------------------------------------------------------------------------------------------
# polysel_shufflesets_cluster.sh
# script to create p-value null distribution by shuffling gene scores and retesting sets
#-------------------------------------------------------------------------------------------

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load R/3.3.0

main_script="polysel_shufflesets_cluster.R"
runnr=$1

#-------------------------------------------------------------------------------------------
# project specific parameters
#-------------------------------------------------------------------------------------------

projectname=$2

# POSITIVE SELECTION IN PRIMATES PROJECT
# Daub et al. (in preparation)
# Detection of pathways affected by positive selection in primate lineages ancestral to humans
# Total nr of runs: 300
if [ ${projectname:0:8} = "primates" ]; then
	branch=${projectname:9}
	projectdir="primates/$branch"
	nrand=1000000
	approxnull="FALSE"
	seqrndsampling="TRUE"
	usebins="FALSE"
fi

# POSITIVE SELECTION IN PRIMATES PROJECT
# Daub et al. (in preparation)
# Detection of pathways affected by positive selection in primate lineages ancestral to humans
if [ $projectname = "African" ]; then    
        projectdir="African"
        nrand=1000000
        approxnull="FALSE"
        seqrndsampling="TRUE"
        usebins="FALSE"
fi

# POSITIVE SELECTION IN PRIMATES PROJECT
# Daub et al. (in preparation)
# Detection of pathways affected by positive selection in primate lineages ancestral to humans
if [ $projectname = "BD" ]; then
        projectdir="BD"
        nrand=1000000
        approxnull="FALSE"
        seqrndsampling="TRUE"
        usebins="FALSE"
fi

# POSITIVE SELECTION IN PRIMATES PROJECT
# Daub et al. (in preparation)
# Detection of pathways affected by positive selection in primate lineages ancestral to humans
if [ $projectname = "MW" ]; then
        projectdir="MW"
        nrand=1000000
        approxnull="FALSE"
        seqrndsampling="TRUE"
        usebins="FALSE"
fi

# POSITIVE SELECTION IN PRIMATES PROJECT
# Daub et al. (in preparation)
# Detection of pathways affected by positive selection in primate lineages ancestral to humans
if [ $projectname = "GW" ]; then
        projectdir="GW"
        nrand=1000000
        approxnull="FALSE"
        seqrndsampling="TRUE"
        usebins="FALSE"
fi

# POSITIVE SELECTION IN PRIMATES PROJECT
# Daub et al. (in preparation)
# Detection of pathways affected by positive selection in primate lineages ancestral to humans
if [ $projectname = "Dhole" ]; then
        projectdir="Dhole"
        nrand=1000000
        approxnull="FALSE"
        seqrndsampling="TRUE"
        usebins="FALSE"
fi

# LOCAL ADAPTATION IN HUMAN POPULATIONS PROJECT
# Daub et al. (2013)
# Evidence for Polygenic Adaptation to Pathogens in the Human Genome. 
# Mol Biol Evol 30, 1544�1558.
# Total nr of runs: 200
if [ $projectname = "humanpops" ]; then
	projectdir="humanpops"
	nrand=1
	approxnull="TRUE"
	seqrndsampling="FALSE"
	usebins="FALSE"
fi

# ADAPTATION TO HIGH ALTITUDE PROJECT
# Foll et al. (2014)
# Widespread Signals of Convergent Adaptation to High Altitude in Asia and America. 
# The American Journal of Human Genetics 95, 394�407.
# Total nr of runs: 200
if [ $projectname = "altitude" ]; then
	projectdir="altitude"
	nrand=500000
	approxnull="FALSE"
	seqrndsampling="TRUE"
	usebins="TRUE"
fi

# ADAPTATION TO FORESTS PROJECT
# Amorim et al. (2015)
# Detection of Convergent Genome-Wide Signals of Adaptation to Tropical Forests in Humans. 
# PLoS One 10.
# Total nr of runs: 300
if [ ${projectname:0:6} = "forest" ]; then
	popset=${projectname:7}
	projectdir="forest/$branch"
	nrand=500000
	approxnull="FALSE"
	seqrndsampling="TRUE"
	usebins="TRUE"
fi

#-------------------------------------------------------------------------------------------
# general test parameters
#-------------------------------------------------------------------------------------------
minsetsize=10
test="highertail"

#-------------------------------------------------------------------------------------------
# cluster parameters
#-------------------------------------------------------------------------------------------
datapath="./data"
codepath="./R"
empfdrpath="./empfdr"

#-------------------------------------------------------------------------------------------
# Lauch R
#-------------------------------------------------------------------------------------------
chmod +x "$codepath/$main_script"
cat "$codepath/$main_script" | R --vanilla --args $runnr $nrand $minsetsize $approxnull $test \
$seqrndsampling $usebins ${projectname} ${datapath}/${projectdir} ${codepath} ${empfdrpath}
