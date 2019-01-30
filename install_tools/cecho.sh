#!/bin/sh

# source me in your script or .bashrc/.zshrc if wanna use cecho
# source '/path/to/cecho.sh'

# check this var to detect "cecho" being imported
CECHO_IS_IMPORTED=1

cecho()
{
    #FOREGROUND

    local FG_BLACK="\e[30m"
    local FG_RED="\e[31m"
    local FG_GREEN="\e[32m"
    local FG_YELLOW="\e[33m"
    local FG_BLUE="\e[34m"
    local FG_PURPLE="\e[35m"
    local FG_CYAN="\e[36m"
    local FG_WHITE="\e[37m"

    #BACKGROUND

    local BG_BLACK="\e[40m"
    local BG_RED="\e[41m"
    local BG_GREEN="\e[42m"
    local BG_YELLOW="\e[43m"
    local BG_BLUE="\e[44m"
    local BG_PURPLE="\e[45m"
    local BG_CYAN="\e[46m"
    local BG_WHITE="\e[47m"

    #ACTION

    local DONE="\e[0m"
    local HIGHLIGHT="\e[1m"
    local UNDERLINE="\e[4m"
    local BLINK="\e[5m"
    local REVERSE="\e[7m"
    local INVISIBLE="\e[8m"

    # for Bash compatibility

    local WS="\\ "

    # for self-adapting: inactive if output is pipe/file, active if screen

    local CECHO_IS_INACTIVE_INTL=$CECHO_IS_INACTIVE
    if [ ! -t 1 ]
    then
        CECHO_IS_INACTIVE_INTL=1
    fi

    # for keeping format when inactive

    local IS_NEED_BLANK=
    local INTL_SINGLE_BLANK=

    # other

    local msg=
    
    local version_info='cecho \
        cecho -B 0.2 -B "<https://github.com/springlie/cecho>" -n \
        Written -B by -B Springlie -B "<springlie@163.com>"'

    local help_info='cecho \
        -r -hl -re -t -t -t -t "the page is generated by" -B -bl "cecho" -d -r -hl -re -t -t -t -t -d -n \
        -hl Usage: -d -n \
        -t "a light and simple wrapper of echo, with colour flags." -d -n -n \
        -hl Syntax: -d -n \
        -t -g -hl cecho -d -B -y -color1 -B -b message1 -w -B "[ -color2 message2 ... ]" -r -B "[ -done ]" -d -n \
        -t -g -hl cecho -d -B -y -fg_color -B -p -bg_color -B -c -action -B -b message -B -w "[...]" -B -r "[ -done ]" -d -n -n \
        -hl "ForeGround color flag:" -d -n \
        -t -r "-r | -red" -t -g "-g | -green" -t -y "-y | -yellow" -t -bk -bw "-bk | -black" -d "(here with white bg)" -d -n \
        -t -b "-b | -blue" -t -p "-p | -purple" -t -c "-c | -cyan" -t -w "-w | -gr | -white | -gray" -d -n -n \
        -hl "BackGround color flag:" -d -n \
        -t -br "-br | -b_red" -t -bg "-bg | -b_green" -t -by "-by | -b_yellow" -t -bbk "-bbk | -b_black" -d -n \
        -t -bb "-bb | -b_blue" -t -bp "-bp | -b_purple" -t -bc "-bc | -b_cyan" -t -bw "-bw | -bgr | -b_white | -b_gray" -d -n -n \
        -hl "Action flag:" -d -n \
        -t "-d  | -done" -t -hl "-hl | -highlight" -d -t -ul "-ul | -underline" -d -t -re "-re | -reverse" -d -n \
        -t -bl "-bl | -blink" -d -t "[ there is invisible here ]" -t "-->" -iv "-iv | -invisible" -d "<--" -n -n \
        -hl "Escaped character:" -d -n \
        -t "-B | -blank" -t "-t | -tab" -t "-n | -newline" -d -n \
        -g -hl -re -t -t -t -t "the src of above (as an example)" -t -t -t -d'

    # main looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooop

    while (($#!=0))
    do

        # set internal single blank(avoid duplicate blanks in inactive mode)

        if [ -z $IS_NEED_BLANK ]
        then
            INTL_SINGLE_BLANK=""
        else
            INTL_SINGLE_BLANK=" "
        fi

        IS_NEED_BLANK=

        
    # switch

    case $1 in

        # escape character

        -B|-blank  |$WS-B|$WS-blank  )msg+=" " ;    ;;
        -t|-tab    |$WS-t|$WS-tab    )msg+="\t";    ;;
        -n|-newline|$WS-n|$WS-newline)msg+="\n";    ;;

        # foreground color

        -bk|-black |$WS-bk|$WS-black       )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $FG_BLACK || echo $INTL_SINGLE_BLANK);   ;;
        -r |-red   |$WS-r |$WS-red         )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $FG_RED   || echo $INTL_SINGLE_BLANK);   ;;
        -g |-green |$WS-g |$WS-green       )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $FG_GREEN || echo $INTL_SINGLE_BLANK);   ;;
        -y |-yellow|$WS-y |$WS-yellow      )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $FG_YELLOW|| echo $INTL_SINGLE_BLANK);   ;;
        -b |-blue  |$WS-b |$WS-blue        )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $FG_BLUE  || echo $INTL_SINGLE_BLANK);   ;;
        -p |-purple|$WS-p |$WS-purple      )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $FG_PURPLE|| echo $INTL_SINGLE_BLANK);   ;;
        -c |-cyan  |$WS-c |$WS-cyan        )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $FG_CYAN  || echo $INTL_SINGLE_BLANK);   ;;
        -w |-white |$WS-w |$WS-white       )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $FG_WHITE || echo $INTL_SINGLE_BLANK);   ;;
        -gr|-gray  |$WS-gr|$WS-gray        )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $FG_WHITE || echo $INTL_SINGLE_BLANK);   ;;

        # background color

        -bbk|-b_black |$WS-bbk|$WS-b_black )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $BG_BLACK || echo $INTL_SINGLE_BLANK);   ;;
        -br |-b_red   |$WS-br |$WS-b_red   )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $BG_RED   || echo $INTL_SINGLE_BLANK);   ;;
        -bg |-b_green |$WS-bg |$WS-b_green )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $BG_GREEN || echo $INTL_SINGLE_BLANK);   ;;
        -by |-b_yellow|$WS-by |$WS-b_yellow)msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $BG_YELLOW|| echo $INTL_SINGLE_BLANK);   ;;
        -bb |-b_blue  |$WS-bb |$WS-b_blue  )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $BG_BLUE  || echo $INTL_SINGLE_BLANK);   ;;
        -bp |-b_purple|$WS-bp |$WS-b_purple)msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $BG_PURPLE|| echo $INTL_SINGLE_BLANK);   ;;
        -bc |-b_cyan  |$WS-bc |$WS-b_cyan  )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $BG_CYAN  || echo $INTL_SINGLE_BLANK);   ;;
        -bw |-b_white |$WS-bw |$WS-b_white )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $BG_WHITE || echo $INTL_SINGLE_BLANK);   ;;
        -bgr|-b_gray  |$WS-bgr|$WS-b_gray  )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $BG_WHITE || echo $INTL_SINGLE_BLANK);   ;;

        # action, some can be overlaid

        -d |-done     |$WS-d |$WS-done     )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $DONE     || echo $INTL_SINGLE_BLANK);   ;;
        -hl|-highlight|$WS-hl|$WS-highlight)msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $HIGHLIGHT|| echo $INTL_SINGLE_BLANK);   ;;
        -ul|-underline|$WS-ul|$WS-underline)msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $UNDERLINE|| echo $INTL_SINGLE_BLANK);   ;;
        -bl|-blink    |$WS-bl|$WS-blink    )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $BLINK    || echo $INTL_SINGLE_BLANK);   ;;
        -re|-reverse  |$WS-re|$WS-reverse  )msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $REVERSE  || echo $INTL_SINGLE_BLANK);   ;;
        -iv|-invisible|$WS-iv|$WS-invisible)msg+=$([ -z $CECHO_IS_INACTIVE_INTL ] && echo $INVISIBLE|| echo $INTL_SINGLE_BLANK);   ;;

        # functional

        -v|-version|--version|$WS-v|$WS-version|$WS--version)
            eval $version_info
            return 0
        ;;

        -h|-help|--help|$WS-h|$WS-help|$WS--help)
            eval $help_info

            if [ $0 "==" "bash" ]
            then
                echo $help_info | sed -r 's/\\/\\\n/g'
            else
                echo $help_info
            fi

            return 0
        ;;

        # string

        *)
            msg=$msg$1
            
            # reset

            IS_NEED_BLANK=1
        ;;

    esac
    shift
    done

    # clear

    msg=$DONE$msg$DONE

    # print

    echo -e $msg
}

