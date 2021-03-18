function dev_update {
	for i in $(find $WD/$line/ci/k8s/ -type f -iname "*$line*env-dev")
		do
		drpl_check=$(grep -c 'RPL' $i)
		if [[ $rpl_check == 0 ]]; then
			declare -i DREV_LINE="2"
			declare -i DMEM_LINE="3"
			declare -i DCPU_LINE="4"
			w=$(grep -c REV_HIST_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '1 s/$/\n/' $i
				printf "%*s%s" $x '' "$drev_lim" | sed -i "${DREV_LINE}"'e cat /dev/stdin' $i
			fi
			w=$(grep -c RSRC_MEM_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/REV_HIST_LIM/ a \ \' $i
				printf "%*s%s" $x '' "$dmem_lim" | sed -i "${DMEM_LINE}"'e cat /dev/stdin' $i
			fi
			w=$(grep -c RSRC_CPU_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/RSRC_MEM_LIM/ a \ \' $i
				printf "%*s%s" $x '' "$dcpu_lim" | sed -i "${DCPU_LINE}"'e cat /dev/stdin' $i
			fi
		elif [[ $rpl_check == 1 ]]; then
			declare -i DRPL_LINE=$(cat $i | nl | grep RPL | cut -d$'\t' -f1 | sed  's/^ *//g')
			declare -i DREV_LINE="$DRPL_LINE+1"
			declare -i DMEM_LINE="$DRPL_LINE+2"
			declare -i DCPU_LINE="$DRPL_LINE+3"
			w=$(grep -c REV_HIST_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/RPL/ a \ \' $i
				printf "%*s%s" $x '' "$drev_lim" | sed -i "${DREV_LINE}"'e cat /dev/stdin' $i
			fi
			w=$(grep -c RSRC_MEM_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/REV_HIST_LIM/ a \ \' $i
				printf "%*s%s" $x '' "$dmem_lim" | sed -i "${DMEM_LINE}"'e cat /dev/stdin' $i
			fi
			w=$(grep -c RSRC_CPU_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/RSRC_MEM_LIM/ a \ \' $i
				printf "%*s%s" $x '' "$dcpu_lim" | sed -i "${DCPU_LINE}"'e cat /dev/stdin' $i
			fi
		fi
        done
}
function stage_update {
		for i in $(find $WD/$line/ci/k8s/ -iname "*$line*env-stage")
        do
		srpl_check=$(grep -c 'RPL' $i)
		if [[ $srpl_check == 0 ]]; then
			declare -i SREV_LINE="2"
			declare -i SMEM_LINE="3"
			declare -i SCPU_LINE="4"
			w=$(grep -c REV_HIST_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '1 s/$/\n/' $i
				printf "%*s%s" $x '' "$srev_lim" | sed -i "${SREV_LINE}"'e cat /dev/stdin' $i
			fi
			w=$(grep -c RSRC_MEM_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/REV_HIST_LIM/ a \ \' $i
				printf "%*s%s" $x '' "$smem_lim" | sed -i "${SMEM_LINE}"'e cat /dev/stdin' $i
			fi
			w=$(grep -c RSRC_CPU_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/RSRC_MEM_LIM/ a \ \' $i
				printf "%*s%s" $x '' "$scpu_lim" | sed -i "${SCPU_LINE}"'e cat /dev/stdin' $i
			fi
		elif [[ $srpl_check == 1 ]]
			declare -i SRPL_LINE=$(cat $i | nl | grep RPL | cut -d$'\t' -f1 | sed  's/^ *//g')
			declare -i SREV_LINE="$SRPL_LINE+1"
			declare -i SMEM_LINE="$SRPL_LINE+2"
			declare -i SCPU_LINE="$SRPL_LINE+3"
			w=$(grep -c REV_HIST_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/RPL/ a \ \' $i
				printf "%*s%s" $x '' "$srev_lim" | sed -i "${SREV_LINE}"'e cat /dev/stdin' $i
			fi
			w=$(grep -c RSRC_MEM_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/REV_HIST_LIM/ a \ \' $i
				printf "%*s%s" $x '' "$smem_lim" | sed -i "${SMEM_LINE}"'e cat /dev/stdin' $i
			fi
			w=$(grep -c RSRC_CPU_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/RSRC_MEM_LIM/ a \ \' $i
				printf "%*s%s" $x '' "$scpu_lim" | sed -i "${SCPU_LINE}"'e cat /dev/stdin' $i
			fi
		fi
        done
}
function prod_update {
		for i in $(find $WD/$line/ci/k8s/ -iname "*$line*env-prod")
        do
		prpl_check=$(grep -c 'RPL' $i)
		if [[ $prpl_check == 0 ]]; then
			declare -i PREV_LINE="1"
			declare -i PMEM_LINE="2"
			declare -i PCPU_LINE="3"
			w=$(grep -c REV_HIST_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '1 s/$/\n/' $i
				printf "%*s%s" $x '' "$prev_lim" | sed -i "${PREV_LINE}"'e cat /dev/stdin' $i
			fi
			w=$(grep -c RSRC_MEM_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/REV_HIST_LIM/ a \ \' $i
				printf "%*s%s" $x '' "$pmem_lim" | sed -i "${PMEM_LINE}"'e cat /dev/stdin' $i
			fi
			w=$(grep -c RSRC_CPU_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/RSRC_MEM_LIM/ a \ \' $i
				printf "%*s%s" $x '' "$pcpu_lim" | sed -i "${PCPU_LINE}"'e cat /dev/stdin' $i
			fi
		elif [[ $prpl_check == 1 ]]; then
			declare -i PRPL_LINE=$(cat $i | nl | grep RPL | cut -d$'\t' -f1 | sed  's/^ *//g')
			declare -i PREV_LINE="$PRPL_LINE+1"
			declare -i PMEM_LINE="$PRPL_LINE+2"
			declare -i PCPU_LINE="$PRPL_LINE+3"
			w=$(grep -c REV_HIST_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/RPL/ a \ \' $i
				printf "%*s%s" $x '' "$prev_lim" | sed -i "${PREV_LINE}"'e cat /dev/stdin' $i
			fi
			w=$(grep -c RSRC_MEM_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/REV_HIST_LIM/ a \ \' $i
				printf "%*s%s" $x '' "$pmem_lim" | sed -i "${PMEM_LINE}"'e cat /dev/stdin' $i
			fi
			w=$(grep -c RSRC_CPU_LIM $i)
			if [[ $w == 0 ]]; then
				sed -i '/RSRC_MEM_LIM/ a \ \' $i
				printf "%*s%s" $x '' "$pcpu_lim" | sed -i "${PCPU_LINE}"'e cat /dev/stdin' $i
			fi
		fi
        done
}
function deploy_update {
		for i in $(find $WD/$line/ci/k8s/ -iname "*$line*deployment.yaml")
        do
		declare -i RPL_NUM=$(cat $i | grep 'replicas:' | sed '1s/[^ \t]//g' | wc -c)
		declare -i REV_NUM="$RPL_NUM-2"
		declare -i RPL_LINE=$(cat $i | nl | grep 'replicas:' | cut -d$'\t' -f1 | sed  's/^ *//g')
		#declare -i RPL_LINE=$(awk '/RPL/{ print NR; exit }' $i)
		declare -i REV_LINE="$RPL_LINE+1"
		w=$(grep -c revisionHistoryLimit $i)
		if [[ $w == 0 ]]; then
			sed -i '/replicas:/ a \ \' $i
			printf "%*s%s" $REV_NUM '' "$rev" | sed -i "${REV_LINE}"'e cat /dev/stdin' $i
		fi
		declare -i NUM_SPC=$(cat $i | grep imagePullPolicy | sed '1s/[^ \t]//g' | wc -c)
		declare -i RNUM="$NUM_SPC-2"
		declare -i LNUM="$NUM_SPC"
		declare -i MNUM="$NUM_SPC+2"
		declare -i CNUM="$NUM_SPC+2"
		declare -i LINE=$(cat $i | nl | grep imagePullPolicy | cut -d$'\t' -f1 | sed  's/^ *//g')
		#declare -i LINE=$(awk '/imagePullPolicy/{ print NR; exit }' )
		declare -i RLINE="$LINE+1"
		declare -i LLINE="$LINE+2"
		declare -i MLINE="$LINE+3"
		declare -i CLINE="$LINE+4"
		w=$(grep -c 'resources:' $i)
		if [[ $w == 0 ]]; then
			sed -i '/imagePullPolicy/ a \ \' $i
			printf "%*s%s" $RNUM '' "$r" | sed -i "${RLINE}"'e cat /dev/stdin' $i
		fi
		w=$(grep -c 'limits:' $i)
		if [[ $w == 0 ]]; then
			sed -i '/resources/ a \ \' $i
			printf "%*s%s" $LNUM '' "$l" | sed -i "${LLINE}"'e cat /dev/stdin' $i
		fi
		w=$(grep -c RSRC_MEM_LIM $i)
		if [[ $w == 0 ]]; then
			sed -i '/limits/ a \ \' $i
			printf "%*s%s" $MNUM '' "$m" | sed -i "${MLINE}"'e cat /dev/stdin' $i
		fi
		w=$(grep -c RSRC_CPU_LIM $i)
		if [[ $w == 0 ]]; then
			sed -i '/RSRC_MEM_LIM/ a \ \' $i
			printf "%*s%s" $CNUM '' "$c" | sed -i "${CLINE}"'e cat /dev/stdin' $i
		fi
        done
}
function syntax_checker {
		for i in $(find $WD/$line/ci/k8s/ -iname "*$line*deployment.yaml")
 	   	do
			yamllint -c $WD/.yamllint $i >> $LOG_FILE_SUCCESS
			echo "---------------------------------"
		done
}
function logger {
		cd $WD/$line 
		git diff --name-only > $CHNG_FILE
		declare -i CNT=$(egrep -c -e "*$line*" $CHNG_FILE)
		echo "$CNT file(s) changed within your project !" >> $LOG_FILE_SUCCESS
		echo "" >> $LOG_FILE_SUCCESS
		if [[ $CNT -gt 0 ]];then 
			echo "Here are the file(s) that changed :" >> $LOG_FILE_SUCCESS
		fi
		echo "" >> $LOG_FILE_SUCCESS
		cat $CHNG_FILE >> $LOG_FILE_SUCCESS
		echo "" >> $LOG_FILE_SUCCESS
		echo "--------------------------------" >> $LOG_FILE_SUCCESS

		if [[ $ddiff -gt 0 ]];then
			echo "$ddiff line(s) changed in DEV file(s) including:" >> $LOG_FILE_SUCCESS
		fi
		for i in $(cat $CHNG_FILE | egrep "*$line*" | egrep "*env-dev")
			do
				if [[ $ddiff -gt 0 ]];then
					echo $i >> $LOG_FILE_SUCCESS
				fi
			done

		if [[ $sdiff -gt 0 ]];then
			echo "$sdiff line(s) changed in Stage file(s) including:" >> $LOG_FILE_SUCCESS
		fi
		for i in $(cat $CHNG_FILE | egrep "*$line*" | egrep "*env-stage")
			do
				if [[ $sdiff -gt 0 ]];then
					echo $i >> $LOG_FILE_SUCCESS
				fi
			done

		if [[ $pdiff -gt 0 ]];then
			echo "$pdiff line(s) changed in Production file(s) including:" >> $LOG_FILE_SUCCESS
		fi
		for i in $(cat $CHNG_FILE | egrep "*$line*" | egrep "*env-prod")
			do
				if [[ $pdiff -gt 0 ]];then
					echo $i >> $LOG_FILE_SUCCESS
				fi
			done

		if [[ $depdiff -gt 0 ]];then
			echo "$depdiff line(s) changed in Deployment file(s) including:" >> $LOG_FILE_SUCCESS
		fi
		for i in $(cat $CHNG_FILE | egrep "*$line*" | egrep "*deployment.yaml")
			do
				if [[ $depdiff -gt 0 ]];then
					echo $i >> $LOG_FILE_SUCCESS
				fi
			done
		echo "------------------------------------------" >> $LOG_FILE_SUCCESS
}