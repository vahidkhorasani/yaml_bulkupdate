#!/bin/sh
# Make sure you have 'git & yamllint' installed on your system before going any further !
WD="~/test"
FILE_LIST="$WD/.list"
PR_NAME=$(ls -1 $WD > $FILE_LIST)
CHNG_FILE="$WD/.changes"
LOG_FILE="$WD/.log"
x=2

# Make test directory to clone your projects into it ! 
# Use git to clone your project in ~/test if you've not already !
if [[ ! -e $WD ]]; then
    mkdir $WD
elif [[ ! -d $dir ]]; then
    echo "$WD already exists but is not a directory" 1>&2
fi

while read line 
	do 
		declare -i bdl=$(wc -l $WD/$line/ci/k8s/$line-env-dev)
		declare -i bsl=$(wc -l $WD/$line/ci/k8s/$line-env-stage)
		declare -i bpl=$(wc -l $WD/$line/ci/k8s/$line-env-prod)
		declare -i bdepl=$(wc -l $WD/$line/ci/k8s/$line-deployment.yaml)

		#### Setting Dev Environment Variables
		echo "Setting Dev Environment Variables ..."

		DEV=$(find $WD/$line/ci/k8s/ -iname "$line-env-dev")
		declare -i DRPL_LINE=$(find $WD/$line/ci/k8s/ -iname "$line-env-dev" | xargs -I {} cat {} | nl | grep RPL | cut -d$'\t' -f1 | sed  's/^ *//g')
		declare -i DREV_LINE="$DRPL_LINE+1"
		declare -i DMEM_LINE="$DRPL_LINE+2"
		declare -i DCPU_LINE="$DRPL_LINE+3"

		drev_lim='REV_HIST_LIM="1"'
		dmem_lim='RSRC_MEM_LIM="512Mi"'
		dcpu_lim='RSRC_CPU_LIM="1"'

		sed -i '/RPL/ a \ \' $DEV
		printf "%*s%s" $x '' "$drev_lim" | sed -i "${DREV_LINE}"'e cat /dev/stdin' $DEV
		sed -i '/REV_HIST_LIM/ a \ \' $DEV
		printf "%*s%s" $x '' "$dmem_lim" | sed -i "${DMEM_LINE}"'e cat /dev/stdin' $DEV
		sed -i '/RSRC_MEM_LIM/ a \ \' $DEV
		printf "%*s%s" $x '' "$dcpu_lim" | sed -i "${DCPU_LINE}"'e cat /dev/stdin' $DEV

		echo "Finished"

		#sed -i -e '$a\ \ REV_HIST_LIM="1"' $WD/$line/ci/k8s/$line-env-dev
		#sed -i -e '$a\ \ RSRC_MEM_LIM="512Mi"' $WD/$line/ci/k8s/$line-env-dev
		#sed -i -e '$a\ \ RSRC_CPU_LIM="1"' $WD/$line/ci/k8s/$line-env-dev


		#### Setting Stage Environment Variables
		echo "Setting Stage Environment Variables ..."

		STAGE=$(find $WD/$line/ci/k8s/ -iname "$line-env-stage")
		declare -i SRPL_LINE=$(find $WD/$line/ci/k8s/ -iname "$line-env-stage" | xargs -I {} cat {} | nl | grep RPL | cut -d$'\t' -f1 | sed  's/^ *//g')
		declare -i SREV_LINE="$SRPL_LINE+1"
		declare -i SMEM_LINE="$SRPL_LINE+2"
		declare -i SCPU_LINE="$SRPL_LINE+3"

		srev_lim='REV_HIST_LIM="1"'
		smem_lim='RSRC_MEM_LIM="512Mi"'
		scpu_lim='RSRC_CPU_LIM="1"'

		sed -i '/RPL/ a \ \' $STAGE
		printf "%*s%s" $x '' "$srev_lim" | sed -i "${SREV_LINE}"'e cat /dev/stdin' $STAGE
		sed -i '/REV_HIST_LIM/ a \ \' $STAGE
		printf "%*s%s" $x '' "$smem_lim" | sed -i "${SMEM_LINE}"'e cat /dev/stdin' $STAGE
		sed -i '/RSRC_MEM_LIM/ a \ \' $STAGE
		printf "%*s%s" $x '' "$scpu_lim" | sed -i "${SCPU_LINE}"'e cat /dev/stdin' $STAGE

		#sed -i -e '$a\ \ REV_HIST_LIM="1"' $WD/$line/ci/k8s/$line-env-stage
		#sed -i -e '$a\ \ RSRC_MEM_LIM="512Mi"' $WD/$line/ci/k8s/$line-env-stage
		#sed -i -e '$a\ \ RSRC_CPU_LIM="1"' $WD/$line/ci/k8s/$line-env-stage

		echo "Finished"

		#### Setting Production Environment Variables
		echo "Setting Production Environment Variables ..."

		PROD=$(find $WD/$line/ci/k8s/ -iname "$line-env-prod")
		declare -i PRPL_LINE=$(find $WD/$line/ci/k8s/ -iname "$line-env-prod" | xargs -I {} cat {} | nl | grep RPL | cut -d$'\t' -f1 | sed  's/^ *//g')
		declare -i PREV_LINE="$PRPL_LINE+1"
		declare -i PMEM_LINE="$PRPL_LINE+2"
		declare -i PCPU_LINE="$PRPL_LINE+3"

		prev_lim='REV_HIST_LIM="5"'
		pmem_lim='RSRC_MEM_LIM="4Gi"'
		pcpu_lim='RSRC_CPU_LIM="4"'

		sed -i '/RPL/ a \ \' $PROD
		printf "%*s%s" $x '' "$prev_lim" | sed -i "${PREV_LINE}"'e cat /dev/stdin' $PROD
		sed -i '/REV_HIST_LIM/ a \ \' $PROD
		printf "%*s%s" $x '' "$pmem_lim" | sed -i "${PMEM_LINE}"'e cat /dev/stdin' $PROD
		sed -i '/RSRC_MEM_LIM/ a \ \' $PROD
		printf "%*s%s" $x '' "$pcpu_lim" | sed -i "${PCPU_LINE}"'e cat /dev/stdin' $PROD

		#sed -i -e '$a\ \ REV_HIST_LIM="5"' $WD/$line/ci/k8s/$line-env-prod
		#sed -i -e '$a\ \ RSRC_MEM_LIM="4Gi"' $WD/$line/ci/k8s/$line-env-prod
		#sed -i -e '$a\ \ RSRC_CPU_LIM="4"' $WD/$line/ci/k8s/$line-env-prod

		echo "Finished"

		#### Configuring Deployment file
		echo "Configuring Deployment file ..."

		r='resources:'
		l='limits:'
		m='memory: "$RSRC_MEM_LIM"'
		c='cpu: "$RSRC_CPU_LIM"'
		rev='revisionHistoryLimit: "$REV_HIST_LIM"'

		FLE=$(find $WD/$line/ci/k8s/ -iname "$line-deployment.yaml")

		declare -i RPL_NUM=$(find $WD/$line/ci/k8s/ -iname "$line-deployment.yaml" | xargs -I {} cat {} | grep RPL | sed '1s/[^ \t]//g' | wc -c)
		declare -i REV_NUM="$RPL_NUM-2"

		declare -i RPL_LINE=$(find $WD/$line/ci/k8s/ -iname "$line-deployment.yaml" | xargs -I {} cat {} | nl | grep RPL | cut -d$'\t' -f1 | sed  's/^ *//g')
		declare -i REV_LINE="$RPL_LINE+1"

		sed -i '/RPL/ a \ \' $FLE
		printf "%*s%s" $REV_NUM '' "$rev" | sed -i "${REV_LINE}"'e cat /dev/stdin' $FLE

		declare -i NUM_SPC=$(find $WD/$line/ci/k8s/ -iname "$line-deployment.yaml" | xargs -I {} cat {} | grep imagePullPolicy | sed '1s/[^ \t]//g' | wc -c)
		declare -i RNUM="$NUM_SPC-2"
		declare -i LNUM="$NUM_SPC"
		declare -i MNUM="$NUM_SPC+2"
		declare -i CNUM="$NUM_SPC+2"

		declare -i LINE=$(find $WD/$line/ci/k8s/ -iname "$line-deployment.yaml" | xargs -I {} cat {} | nl | grep imagePullPolicy | cut -d$'\t' -f1 | sed  's/^ *//g')
		declare -i RLINE="$LINE+1"
		declare -i LLINE="$LINE+2"
		declare -i MLINE="$LINE+3"
		declare -i CLINE="$LINE+4"

		sed -i '/imagePullPolicy/ a \ \' $FLE
		printf "%*s%s" $RNUM '' "$r" | sed -i "${RLINE}"'e cat /dev/stdin' $FLE
		sed -i '/resources/ a \ \' $FLE
		printf "%*s%s" $LNUM '' "$l" | sed -i "${LLINE}"'e cat /dev/stdin' $FLE
		sed -i '/limits/ a \ \' $FLE
		printf "%*s%s" $MNUM '' "$m" | sed -i "${MLINE}"'e cat /dev/stdin' $FLE
		sed -i '/RSRC_MEM_LIM/ a \ \' $FLE
		printf "%*s%s" $CNUM '' "$c" | sed -i "${CLINE}"'e cat /dev/stdin' $FLE

		echo "Finished configuring files !!"

		echo "Let's Check files syntax, you can check it in $LOG_FILE"

		date >> $LOG_FILE
		yamllint $WD/$line/ci/k8s/$line-env-dev >> $LOG_FILE
		echo "----------------------------------"
		yamllint $WD/$line/ci/k8s/$line-env-stage >> $LOG_FILE
		echo "----------------------------------"
		yamllint $WD/$line/ci/k8s/$line-env-prod >> $LOG_FILE
		echo "----------------------------------"
		yamllint $WD/$line/ci/k8s/$line-deployment.yaml >> $LOG_FILE
		echo "----------------------------------"

		declare -i adl=$(wc -l $WD/$line/ci/k8s/$line-env-dev)
		declare -i asl=$(wc -l $WD/$line/ci/k8s/$line-env-stage)
		declare -i apl=$(wc -l $WD/$line/ci/k8s/$line-env-prod)
		declare -i adepl=$(wc -l $WD/$line/ci/k8s/$line-deployment.yaml)

		# Check Changed files
		echo "Checking changed files"
		cd $WD/$line 
		git diff --name-only > $CHNG_FILE
		egrep -c -e "dev|stage|prod|deployment" > $CHNG_FILE
		egrep -e "dev|stage|prod|deployment" > $CASE_FILE
		echo "$CHNG_FILE files changed within your project !"
		echo "Here are the files that changed :"
		cat $CHNG_FILE
		echo "----------------------------------"
		echo "$(adl-bdl) lines added to $WD/$line/ci/k8s/$line-env-dev"
		echo "$(asl-bsl) lines added to $WD/$line/ci/k8s/$line-env-stage"
		echo "$(apl-bpl) lines added to $WD/$line/ci/k8s/$line-env-prod"
		echo "$(adepl-bdepl) lines added to $WD/$line/ci/k8s/$line-deployment.yaml"
		echo "----------------------------------"

		echo "All Changes completed Successfully !! check to see if there is any error and if not commit your changes."

	done < $FILE_LIST