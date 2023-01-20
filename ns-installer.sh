#!/bin/bash
#
# Nightscout Server Installer
# by Michael Schlömp
# www.michael-schloemp.de
#

#==================================== Imports ===============================================
# Import base
. base/import.sh

# Import Vollinstallation
. vollinstallation/import.sh


# Presentation function and options
welcome(){

clear
echo -e "
${txtcyn}
================================================================================================================================              
                                                  
                  /@@@@@@@@@@@@@*                 
               @@@@@           @@@@@              
             @@@/                 #@@@            
            @@@@@@@@@@@@   @@@@@@@@@@@@           
           @@@&*@@@@@@ @@@@@ @@@@@@.@@@@          
          /@@ @@@   @@@ @@@ @@&   @@@ @@.         
          ,@@ @@@   @@@ @@@ @@@   @@@ @@         Nightscout Server Installer 
           @@@  @@@@@   @@@  .@@@@@  @@@          www.michael-schloemp.de
           @@@@         @@@         @@@%          
            @@@@@,               /@@@@@           
             @@@@@@@@@       @@@@@@@@@            
              @@@,   @@@@@@@@@   (@@&             
                @@@  /@@@       @@@               
                 @@@@@@       @@@&                
                   @@@&     @@@@                  
                     @@@@ @@@@                    
                       &@@@#                      
                                                  
================================================================================================================================
${txtrst}Options:

${Red}########## Vollinstallation / Full installation${txtrst}
 "
for file in $(ls ./vollinstallation)
do
    if [ $file != import.sh ]
    then
        echo $file
    fi

done;
echo -e "






e - Exit

==================================

Enter an option:
"
    read program

case $program in

    # Performs the function with the name of the variable passed
    e) clear; exit;;
    $program) $program; ready;;
    *) welcome;;

esac
}

welcome
