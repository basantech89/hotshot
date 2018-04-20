#!/bin/bash
# $2 is doc
# $1 is mcq

lineNo=13
i=1
while IFS='' read -r line || [[ -n "$line" ]]; do
	if [[ $i == 1 || $i == 7 || $i == 13 || $i == 19 || $i == 25 || $i == 31 || $i == 37 || $i == 43 || $i == 49 || $i == 55 ]]; then
		#sed -i "$lineNo i var item = form.addCheckboxItem();\n\titem.setTitle(\"$line\").setPoints(1).setRequired(true);\nitem.setChoices([" $2
		sed -i "$lineNo i var item = form.addMultipleChoiceItem();\n\titem.setTitle(\"$line\").setPoints(1).setRequired(true);\nitem.setChoices([" $2
		lineNo=$(expr $lineNo + 3)
		i=$(expr $i + 1)
	elif [[ $i == 5 || $i == 11 || $i == 17 || $i == 23 || $i == 29 || $i == 35 || $i == 41 || $i == 47 || $i == 53 || $i == 59 ]]; then
		sed -i "$lineNo i item.createChoice(\"$line\")\n\t]);" $2
		lineNo=$(expr $lineNo + 2)
		i=$(expr $i + 1)
	elif [[ $i == 6 || $i == 12 || $i == 18 || $i == 24 || $i == 30 || $i == 36 || $i == 42 || $i == 48 || $i == 54 ]]; then
		i=$(expr $i + 1)
	else
		sed -i "$lineNo i item.createChoice(\"$line\")," $2
		lineNo=$(expr $lineNo + 1)
		i=$(expr $i + 1)
	fi
done < "$1"
