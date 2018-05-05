
    #!/bin/bash
    #Time tracking script

    function timeStamp() 
    {
  		date "+%r"
	}

	function dateStamp()
	{
		date "+%m-%d-%Y" 
	}

	#Reads a file line by line.  File name should be passed as parameter.
	function getTrackingVars()
	{
		while IFS= read -r line; do
			echo $line
			echo "in the getTrackingVars function"
		done < "$1"
	}


    currentTime=date
    echo $currentTime
    echo "Would you like to create a NEW time tracking entry or continue a PREVIOUS log?"
		while :
		do
		  read entry
		  case $entry in	
			new)
				read -p 'What is the name of your new time record?: ' newEntry
				echo 'You entered: ' $newEntry

				newEntryPath=/Users/$USER/$newEntry
				echo 'Your entered '$newEntryPath
			
				while [ -d $newEntryPath ] 
				do
					read -p 'Directory name already exists.  Choose a new name: ' newEntry
					newEntryPath=/Users/$USER/$newEntry
				done

				#if the dir does not exist create dir and data file
				if [ ! -d $newEntryPath ]
				then
					echo "in if statement"
					mkdir $newEntryPath
					echo 'Your new time entry directory is: '$newEntryPath 
					echo > ${newEntryPath}/$newEntry.dat
					ls -la $newEntryPath

					#New while clause to begin tracking time
					echo 'Would you like to begin tracking your time?'
					while :
					do
					read trackResponse
						case $trackResponse in
							yes)
								beginTimeStamp=$(timeStamp)
								trackStartDate=$(dateStamp)
								echo $beginTimeStamp >> $newEntryPath/$newEntry.dat
								echo $trackStartDate >> $newEntryPath/$newEntry.dat
								echo "This is your time stamp: "$beginTimeStamp
								echo "This is your logged date: "$trackStartDate
								#cat $newEntryPath/$newEntry.dat

								getTrackingVars "$newEntryPath/$newEntry.dat"
								break
								;;
							no)
								echo 'You answered no'
								break
								;;
							*)
								echo 'You entered an incorrect response'
								break
								;;
						esac
					done #end while loop
				fi #end if statement
				break
				;;

			previous)
				read -p 'What is the name of your previous entry?: ' previousEntry
				echo 'You entered: ' $previousEntry
			
				# echo $PWD
					COUNTER=0
					echo $COUNTER

					# while [ -a /Users/$USER/$previousEntry/$previousEntry.dat] || [ $COUNTER=0 ]
					# do
					# 	echo 'test text' >> $previousEntry.dat
					# 	(($COUNTER++))
					# done

				break
				;;

			*)
				echo "Sorry, I don't understand"
				;;
		  esac
		done #end while 

  #   echo "Would you like to add a description to this time log?"
		# while :
		# do
		#   read USERRESPONSE
		#   case $USERRESPONSE in
		# 	yes)
		# 		read -p 'Enter in a short description: ' DESCRIPTION
		# 		echo 'You entered: ' $DESCRIPTION 
		# 		break
		# 		;;
		# 	no)
		# 		echo "See you again!"
		# 		break
		# 		;;
		# 	*)
		# 		echo "Sorry, I don't understand"
		# 		;;
		#   esac
		# done


    #read RESPONSE
    #STARTTIME=$(date)
