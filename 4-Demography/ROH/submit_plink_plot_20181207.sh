#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/vcfs/polymorphic/plink
#$ -l h_rt=01:00:00,h_data=16G
#$ -N plinkROH
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp/plinkROH
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp/plinkROH
#$ -m abe
#$ -M jarobins
#$ -t 1-10:1


# For making temp.txt
# for a in 50 100 200; \
# do for b in 50 100; \
# do for c in 1000 2000 5000; \
# do for d in 50 100 200; \
# do for e in 1 2 3 4 5 10 20; \
# do for f in 1 2 3 4 5 10 20; \
# do for g in .02 .05 .1; \
# do echo $a $b $c $d $e $f $g >> temp.txt ; done; done; done; done; done; done; done


SCRIPT=/u/home/j/jarobins/project-rwayne/utils/scripts/plink_roh/run_plink_plot_20181207.sh

${SCRIPT} $(head -n ${SGE_TASK_ID} temp.txt | tail -n 1)
