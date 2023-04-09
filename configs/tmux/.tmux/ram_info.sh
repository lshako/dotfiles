#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

get_ratio()
{
    # Get used memory blocks with vm_stat, multiply by page size to get size in bytes, then convert to MiB
    used_mem=$(vm_stat | grep ' active\|wired ' | sed 's/[^0-9]//g' | paste -sd ' ' - | awk -v pagesize=$(pagesize) '{printf "%d\n", ($1+$2) * pagesize / 1048576}')
    total_mem=$(system_profiler SPHardwareDataType | grep "Memory:" | awk '{print $2 $3}')
    if ((used_mem < 1024 )); then
    echo "${used_mem}MB/$total_mem"
    else
    memory=$((used_mem/1024))
    echo "${memory}GB/$total_mem"
    fi
    
}

main()
{
  ram_label="RAM:"
  ram_ratio=$(get_ratio)
  echo "$ram_label $ram_ratio"
}

#run main driver
main
