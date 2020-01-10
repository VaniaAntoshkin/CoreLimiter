# Script for limiting process usage CPU cores
# by Anton Vanichkin
# thanks peoples on https://stackoverflow.com and https://superuser.com
# for answers

param (
    [string]$procname="",
    [System.IntPtr]$cores=15
)
if ($procname -eq "")
{
    $msg=@"
    Empty procname variable. Please set -procname variable on start option

    Using:
    core-limit.ps1 [Options]
        -procname process_name :: executable name name of limiting process
        -cores cores_bit_mask_constant :: default value is 15 (1 to 4 cores).
        bit mask example:
        0x1 - 0001 - Core0 constant is 1
        0x2 - 0010 - Core1 constant is 2
        0x3 - 0011 - Core1 & Core0 constant is 3
        0x4 - 0100 - Core2 constant is 4
        0x5 - 0101 - Core2 & Core0 constant is 5
        0x6 - 0110 - Core2 & Core1 constant is 6
        0x7 - 0111 - Core2 & Core1 & Core0 constant is 7
        0x8 - 1000 - Core3 constant is 8
        0x9 - 1001 - Core3 & Core0 constant is 9
        0xA - 1010 - Core3 & Core1 constant is 10
        0xB - 1011 - Core3 & Core1 & Core0 constant is 11
        0xC - 1100 - Core3 & Core2 constant is 12
        0xD - 1101 - Core3 & Core2 & Core0 constant is 13
        0xE - 1110 - Core3 & Core2 & Core1 constant is 14
        0xF - 1111 - Core3 & Core2 & Core1 & Core0 constant is 15
    
"@
    echo $msg
    exit

}
$instances=Get-Process
foreach ($i in $instances)
{
     if ($i.Name -eq $procname)
     {
        if ($i.ProcessorAffinity -ne $cores)
        {
            echo "Setting CPU cores for PID $($i.Id) at $(date)"
            $i.ProcessorAffinity = $cores
        }
     }
}