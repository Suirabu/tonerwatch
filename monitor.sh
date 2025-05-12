#!/usr/bin/env bash

TONER_WARNING_LEVEL=15
PRINTER_CSV="printers.csv"

get_oid_for_color() {
    case "$1" in
        "Black") echo "1.3.6.1.2.1.43.11.1.1.9.1.1" ;;
        "Cyan") echo "1.3.6.1.2.1.43.11.1.1.9.1.2" ;;
        "Magenta") echo "1.3.6.1.2.1.43.11.1.1.9.1.3" ;;
        "Yellow") echo "1.3.6.1.2.1.43.11.1.1.9.1.4" ;;
        *) echo "" ;;
    esac
}

while IFS=',' read -r name location ip is_color; do
    has_low_toner=false
    printed_header=false
    
    if [[ "$is_color" == "TRUE" ]]; then
        colors=("Black" "Cyan" "Magenta" "Yellow")
        color_status="Color"
    else
        colors=("Black")
        color_status="Monochrome"
    fi

    for color in "${colors[@]}"; do
        # get toner level using snmpwalk
        oid=$(get_oid_for_color "$color")
        level=$(snmpwalk -v1 -c public -Oqv "$ip" "$oid" 2>/dev/null)
        
        if (( level <= TONER_WARNING_LEVEL )); then
            if [ "$printed_header" == false ]; then
                echo "$name ($color_status)"
                echo "Location: $location"
                echo "IP: $ip"
                printed_header=true
            fi
            echo "$color toner low: ${level}%"
            has_low_toner=true
        fi
    done

    [[ "$has_low_toner" == true ]] && echo "" # print newline to separate printers in output
done < "$PRINTER_CSV"