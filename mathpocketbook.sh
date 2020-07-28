#First prototype for the math pocketbook
echo -e  "~Welcome to the Math Pocketbook v1.3!\v"
echo -e  "~This application archives and displays a large list of formulas used in various mathematical disciplines.\v"

#Subjects
subjects=( "Algebra" "Geometry" "Trigonometry" "Quit" )

#Formulas for Algebra
algebra_formulas=( "Slope Formula" "Point-Slope form" "Standard form" "Slope-Intercept form" "Vertical-form" "Horizontal-form" "Midpoint Formula" "Distance Formula" "Back" "Quit" )

#Formulas for Geometry
geometry_formulas=( "Area of a Square" "Perimeter of a Square" "Area of a Rectangle" "Perimeter of a Rectangle" "Area of a Triangle" "Area of a Circle" "Circumference of a Circle" "Pythagorean Theorem" "Back" "Quit" )

#Formulas for Trigonometry
trigonometry_formulas=( "Sine function" "Cosine function" "Tangent function" "Cosecant function" "Secant function" "Cotangent function" "Degrees-to-Radians" "Radians-to-Degrees" "Back" "Quit" )

another_formula () {
	while true
	do
		read -p "Do you need another formula? (Y/N): " answer
		if [[ "$answer" == "Y" ]] || [[ "$answer" == "y" ]]; then
			break 2
		elif [[ "$answer" == "N" ]] || [[ "$answer" == "n" ]]; then
			break 5
		else
			echo -e "Invalid entry, please try again"
			continue
		fi
	done
}


display_info (){
	sqlite3 formulas.db "select formula_name from formulas where formula_name='$1';"
	sqlite3 formulas.db "select formula from formulas where formula_name='$1';"
	sqlite3 formulas.db "select description from formulas where formula_name='$1';"
	another_formula
}

while true 	
do	
	echo "~Please select your subject of interest."
	PS3="> "
	select subject in "${subjects[@]}"
	do 
		if [ "$subject" == "" ]; then
			echo -e "Entry is not valid, try again."
			continue
		elif [ $subject = Quit ]; then
			break 2; 
		elif [ "$subject" = "Geometry" ]; then
			while true	
			do	
				echo -e "~Please select a Geometry formula, or press the option number to back/exit."
				select formula in "${geometry_formulas[@]}"
				do
					if [ "$formula" == "" ]; then
						echo -e "Entry is not valid, try again."
						echo -e "Formula: A = w*l\n"
					elif [ "$formula" = "Quit" ]; then
						break 5
					elif [ "$formula" = "Back" ]; then
						break 3
					else
						display_info "$formula"
					fi
				done
			done
		elif [ "$subject" = "Algebra" ]; then
			while true
			do
				echo -e "~Please select an Algebra formula, or press the option number to back/exit."
				select formula in "${algebra_formulas[@]}"
				do
					if [ "$formula" == "" ]; then
                        			echo -e "Entry is not valid, try again."
						continue
              				elif [ "$formula" = "Quit" ]; then
              				        break 5
					elif [ "$formula" = "Back" ]; then
						break 3
					else
						display_info "$formula"
					fi

				done
			done
		elif [ "$subject" = "Trigonometry" ]; then
			while true
			do
				echo -e "~Please select a Trigonometric formula, or press the option number to back/exit."
				select formula in "${trigonometry_formulas[@]}"
				do
					if [ "$formula" == "" ]; then
						echo - e "Entry is not valid, try again."
						continue
					elif [ "$formula" = "Quit" ]; then
						break 5
					elif [ "$formula" = "Back" ]; then
						break 3
					else
						display_info "$formula"
					fi
				done
			done
		fi
	     	
	done
done
