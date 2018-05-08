
    #!/bin/bash
    #Time tracking script

    function setTimeStamp() 
    {
  		date "+%r"
	}

	function setDateStamp()
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

	function getCombinedHours()
	{
		previousTimeStamp
		currentTimeStamp=$(setTimeStamp)
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
					printf "Project name: "$newEntry"\n\n" >> ${newEntryPath}/$newEntry.txt
					ls -la $newEntryPath

					#New while clause to begin tracking time
					echo 'Would you like to begin tracking your time?'
					while :
					do
					read trackResponse
						case $trackResponse in
							yes)
								beginTimeStamp=$(setTimeStamp)
								trackStartDate=$(setDateStamp)
								
								echo "Date: "$trackStartDate >> $newEntryPath/$newEntry.txt
								echo "Start time: "$beginTimeStamp >> $newEntryPath/$newEntry.txt
								
								echo "This is your time stamp: "$beginTimeStamp
								echo "This is your logged date: "$trackStartDate
								

								getTrackingVars "$newEntryPath/$newEntry.txt"
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

					# while [ -a /Users/$USER/$previousEntry/$previousEntry.txt] || [ $COUNTER=0 ]
					# do
					# 	echo 'test text' >> $previousEntry.txt
					# 	(($COUNTER++))
					# done

				break
				;;

			*)
				echo "Sorry, I don't understand"
				;;
		  esac
		done #end while 

